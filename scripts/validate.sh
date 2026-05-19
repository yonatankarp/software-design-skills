#!/usr/bin/env bash
# Validate the ai-skills-market marketplace structure.
# Runs five checks; exits non-zero on any failure.
#
# Usage: ./scripts/validate.sh
# Also invoked by .github/workflows/validate.yml on PRs and pushes to main.

set -euo pipefail

cd "$(dirname "$0")/.."

fail=0
log() { printf '  %s\n' "$*"; }

# 1. JSON syntax
echo "==> JSON syntax"
for f in .claude-plugin/marketplace.json plugins/*/.claude-plugin/plugin.json; do
  if python3 -m json.tool < "$f" > /dev/null 2>&1; then
    log "OK     $f"
  else
    log "FAIL   $f"
    python3 -m json.tool < "$f" 2>&1 | head -3 | sed 's/^/         /'
    fail=1
  fi
done

# 2. Every SKILL.md has YAML frontmatter with name: and description:
echo
echo "==> SKILL.md frontmatter"
for f in plugins/*/skills/*/SKILL.md; do
  if ! head -1 "$f" | grep -qx -- '---'; then
    log "FAIL   no frontmatter start: $f"
    fail=1
    continue
  fi
  if ! awk '/^---$/{c++; next} c==1 && /^name: /{print; exit}' "$f" | grep -q .; then
    log "FAIL   missing 'name:'        $f"
    fail=1
  fi
  if ! awk '/^---$/{c++; next} c==1 && /^description: /{print; exit}' "$f" | grep -q .; then
    log "FAIL   missing 'description:' $f"
    fail=1
  fi
done

# 3. Frontmatter name: matches folder name
echo
echo "==> name: matches folder name"
for f in plugins/*/skills/*/SKILL.md; do
  folder=$(basename "$(dirname "$f")")
  name=$(awk '/^---$/{c++; next} c==1 && /^name: /{sub(/^name:[ \t]*/, ""); print; exit}' "$f")
  if [ "$name" != "$folder" ]; then
    log "FAIL   name='$name'  folder='$folder'  ($f)"
    fail=1
  fi
done

# 4. Marketplace registration is bidirectional
echo
echo "==> Plugin registration (marketplace.json <-> plugins/)"
existing=$(find plugins -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
registered=$(python3 -c "
import json
m = json.load(open('.claude-plugin/marketplace.json'))
print('\n'.join(sorted(p['name'] for p in m['plugins'])))
")
for p in $existing; do
  if ! printf '%s\n' "$registered" | grep -qx "$p"; then
    log "FAIL   plugins/$p exists but is not registered in marketplace.json"
    fail=1
  fi
done
for p in $registered; do
  if ! printf '%s\n' "$existing" | grep -qx "$p"; then
    log "FAIL   marketplace.json registers '$p' but plugins/$p is missing"
    fail=1
  fi
done

# 5. Every skill folder under plugins/*/skills/ has a SKILL.md
echo
echo "==> Every skill folder has SKILL.md"
for d in plugins/*/skills/*/; do
  [ -d "$d" ] || continue
  if [ ! -f "${d}SKILL.md" ]; then
    log "FAIL   missing ${d}SKILL.md"
    fail=1
  fi
done

echo
if [ "$fail" -eq 0 ]; then
  echo "All checks passed"
else
  echo "Validation failed"
  exit 1
fi
