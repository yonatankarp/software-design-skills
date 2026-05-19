# Contributing

## Skill authoring conventions

Every skill is a folder under `plugins/<plugin>/skills/<skill-name>/` containing at minimum a `SKILL.md` file with YAML frontmatter.

### Frontmatter schema

```yaml
---
name: short-kebab-case-name
description: One-paragraph description that BOTH explains what the skill does AND lists the trigger phrases / scenarios that should invoke it. Used by Claude to decide when to load the skill, so be concrete about triggers.
---
```

The `description` is load-bearing — it is what Claude reads to decide whether to invoke the skill. Vague descriptions cause missed triggers; overly broad ones cause spurious triggers. Be specific about both the *what* and the *when*.

### Body structure

A good skill body has:

1. **A one-line summary** — restate what the skill does.
2. **When to use this skill** — bullet list of trigger scenarios. Concrete > abstract.
3. **When NOT to use this skill** — bullet list of close-but-not-matching scenarios that route elsewhere.
4. **Core content** — the actual knowledge / process / checklist.
5. **References to related skills** — cross-links using prose ("see also: `ddd-bounded-context`") so that a mode skill can compose pattern skills.

### Language-agnostic skills

Pattern skills in `ddd-core` are language-agnostic. They:

- Describe concepts in plain prose, not code.
- When examples are helpful, use pseudocode or UML-flavored sketches.
- Defer code generation to language adapter plugins.
- Make decisions explicit (when to apply, when not to, how to choose between alternatives).

### Language adapter skills

Adapter plugins (`ddd-kotlin`, hypothetical `ddd-typescript`) translate pattern decisions into idiomatic language code. They:

- Reference, never duplicate, the pattern skill they implement.
- Show idiomatic language code (data classes, value classes, sealed classes for Kotlin, etc.).
- Note language-specific footguns (e.g., `data class equals` includes all properties).

## Adding a new plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json` with `name`, `version`, `description`, `author`, `license`.
2. Add a `skills/` directory; one folder per skill, each with a `SKILL.md`.
3. Register the plugin in `.claude-plugin/marketplace.json` under `plugins[]`.
4. Open a pull request describing the plugin's purpose and intended trigger surface.

## Design specs

Non-trivial additions (a new plugin, a major restructure) should land a design spec under `docs/specs/YYYY-MM-DD-<topic>-design.md` before implementation. See existing specs for the format.

## Reference material

Shared reference material (e.g., book citations, ASCII diagrams reused across skills) lives in `references/`. Skills cite references via relative paths.

## Validation

Before opening a pull request, run:

```bash
./scripts/validate.sh
```

It runs five checks:

1. **JSON syntax** — `marketplace.json` and every `plugin.json` parses.
2. **SKILL.md frontmatter** — each `SKILL.md` starts with YAML frontmatter containing `name:` and `description:`.
3. **`name:` matches folder name** — the frontmatter `name` field equals the skill's folder name (otherwise discovery breaks silently).
4. **Plugin registration is bidirectional** — every folder under `plugins/` is registered in `marketplace.json`, and every registered plugin folder exists.
5. **No empty skill folders** — every directory under `plugins/*/skills/` has a `SKILL.md`.

The same script runs in CI on every pull request and push to `main` (see `.github/workflows/validate.yml`). The CI workflow has read-only permissions and executes no untrusted input — it just invokes `scripts/validate.sh`.
