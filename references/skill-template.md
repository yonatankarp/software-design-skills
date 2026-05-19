# Skill template

Every SKILL.md in this repo follows the structure below. Copy this skeleton when creating a new skill.

---

```yaml
---
name: skill-name-in-kebab-case
description: One paragraph. Explain (1) what the skill does and (2) the user phrases / scenarios that should trigger it. Mode skills name intents ("design a domain"); pattern skills name both the pattern AND its symptoms ("primitive obsession"); adapter skills name the pattern + language. Avoid generic phrasing — be specific about triggers.
---
```

## One-line summary

One sentence restating what the skill does.

## When to use this skill

- Concrete scenario A
- Concrete scenario B
- Concrete scenario C

## When NOT to use this skill

- Close-but-different scenario X → route to `<other-skill>`
- Close-but-different scenario Y → route to `<other-skill>`

## Core content

The knowledge. Prose. Pseudocode allowed. No language-specific syntax in `ddd-core` skills.

## Decision heuristics

- Apply when: …
- Do NOT apply when: …

## Anti-patterns

- Warning 1 — what it looks like, why it's wrong.
- Warning 2.

## See also

- `related-skill-a` — when to delegate to it.
- `related-skill-b`.

## References

- Evans, *Domain-Driven Design* (2003), Ch. N, pp. X–Y — what to cite from there.
