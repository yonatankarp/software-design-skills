# ai-skills-market

An open-source [Claude Code](https://docs.claude.com/en/docs/claude-code) skill marketplace. Skills are authored as language-agnostic knowledge units and grouped into plugins by topic.

## Plugins

| Plugin | Purpose |
| ------ | ------- |
| **`ddd-core`** | Language-agnostic Domain-Driven Design. Four mode entry points (`ddd-design`, `ddd-review`, `ddd-refactor`, `ddd-implement`) plus thirteen pattern primitives covering Evans's strategic and tactical patterns. |
| **`ddd-kotlin`** | Kotlin idiom adapter for `ddd-core`. |
| **`design-patterns-core`** | Language-agnostic Gang-of-Four design patterns. Three mode entry points (`gof-identify`, `gof-review`, `gof-refactor-to-pattern`) plus seventeen pattern primitives — the thirteen from *Head First Design Patterns* (2nd ed) plus Builder, Prototype, Bridge, Visitor from the broader GoF / Soshin canon. |
| **`design-patterns-kotlin`** | Kotlin idiom adapter for `design-patterns-core`. Calls out where Kotlin language features (`object`, sealed classes, `by` delegation, function types, named arguments, `data class` copy, scope functions) supersede the pattern. Grounded in Soshin's *Kotlin Design Patterns and Best Practices*. |
| **`kotlin-patterns`** | Kotlin-specific patterns that aren't GoF: pattern matching (`sealed` + `when`), higher-order functions, Coroutines patterns (scope, launch vs async, dispatchers, structured concurrency), Flow patterns (cold vs hot, operators), type-safe DSL builders, and a Kotlin anti-pattern catalog. Grounded in Soshin's *Kotlin Design Patterns and Best Practices* Section 2. |

More plugins (other languages, adjacent patterns like CQRS / event sourcing / hexagonal architecture) will live as siblings under `plugins/`.

## Skill index

### `ddd-core` (17 skills)

**Mode skills (entry points):**

- [`ddd-design`](plugins/ddd-core/skills/ddd-design/SKILL.md) — guide a new domain model from brief to draft
- [`ddd-review`](plugins/ddd-core/skills/ddd-review/SKILL.md) — PR-style audit against the DDD anti-pattern catalog
- [`ddd-refactor`](plugins/ddd-core/skills/ddd-refactor/SKILL.md) — sequence small steps toward a target DDD shape
- [`ddd-implement`](plugins/ddd-core/skills/ddd-implement/SKILL.md) — bridge pattern decisions to code via a language adapter

**Strategic patterns:**

- [`ddd-ubiquitous-language`](plugins/ddd-core/skills/ddd-ubiquitous-language/SKILL.md)
- [`ddd-bounded-context`](plugins/ddd-core/skills/ddd-bounded-context/SKILL.md)
- [`ddd-context-mapping`](plugins/ddd-core/skills/ddd-context-mapping/SKILL.md)
- [`ddd-subdomain-classification`](plugins/ddd-core/skills/ddd-subdomain-classification/SKILL.md)

**Tactical patterns:**

- [`ddd-entity`](plugins/ddd-core/skills/ddd-entity/SKILL.md)
- [`ddd-value-object`](plugins/ddd-core/skills/ddd-value-object/SKILL.md)
- [`ddd-aggregate`](plugins/ddd-core/skills/ddd-aggregate/SKILL.md)
- [`ddd-domain-event`](plugins/ddd-core/skills/ddd-domain-event/SKILL.md)
- [`ddd-domain-service`](plugins/ddd-core/skills/ddd-domain-service/SKILL.md)
- [`ddd-repository`](plugins/ddd-core/skills/ddd-repository/SKILL.md)
- [`ddd-factory`](plugins/ddd-core/skills/ddd-factory/SKILL.md)

**Cross-cutting:**

- [`ddd-anti-patterns`](plugins/ddd-core/skills/ddd-anti-patterns/SKILL.md) — catalog cited by `ddd-review` and `ddd-refactor`
- [`ddd-deeper-insight`](plugins/ddd-core/skills/ddd-deeper-insight/SKILL.md) — Evans Part III techniques

### `ddd-kotlin` (1 skill)

- [`ddd-kotlin-idioms`](plugins/ddd-kotlin/skills/ddd-kotlin-idioms/SKILL.md) — pattern → idiomatic Kotlin (stdlib only, no framework opinions)

### `design-patterns-core` (20 skills)

**Mode skills:**

- [`gof-identify`](plugins/design-patterns-core/skills/gof-identify/SKILL.md) — diagnostic: which pattern fits this problem?
- [`gof-review`](plugins/design-patterns-core/skills/gof-review/SKILL.md) — audit existing pattern usage
- [`gof-refactor-to-pattern`](plugins/design-patterns-core/skills/gof-refactor-to-pattern/SKILL.md) — sequence small steps toward a target pattern

**Creational patterns:**

- [`gof-factory`](plugins/design-patterns-core/skills/gof-factory/SKILL.md) — Simple / Method / Abstract together
- [`gof-builder`](plugins/design-patterns-core/skills/gof-builder/SKILL.md)
- [`gof-prototype`](plugins/design-patterns-core/skills/gof-prototype/SKILL.md)
- [`gof-singleton`](plugins/design-patterns-core/skills/gof-singleton/SKILL.md) — with strong anti-pattern caveats

**Structural patterns:**

- [`gof-decorator`](plugins/design-patterns-core/skills/gof-decorator/SKILL.md)
- [`gof-adapter`](plugins/design-patterns-core/skills/gof-adapter/SKILL.md)
- [`gof-facade`](plugins/design-patterns-core/skills/gof-facade/SKILL.md)
- [`gof-bridge`](plugins/design-patterns-core/skills/gof-bridge/SKILL.md)
- [`gof-composite`](plugins/design-patterns-core/skills/gof-composite/SKILL.md)
- [`gof-proxy`](plugins/design-patterns-core/skills/gof-proxy/SKILL.md)

**Behavioral patterns:**

- [`gof-strategy`](plugins/design-patterns-core/skills/gof-strategy/SKILL.md)
- [`gof-state`](plugins/design-patterns-core/skills/gof-state/SKILL.md)
- [`gof-observer`](plugins/design-patterns-core/skills/gof-observer/SKILL.md)
- [`gof-command`](plugins/design-patterns-core/skills/gof-command/SKILL.md)
- [`gof-iterator`](plugins/design-patterns-core/skills/gof-iterator/SKILL.md)
- [`gof-template-method`](plugins/design-patterns-core/skills/gof-template-method/SKILL.md)
- [`gof-visitor`](plugins/design-patterns-core/skills/gof-visitor/SKILL.md)

### `design-patterns-kotlin` (1 skill)

- [`gof-kotlin-idioms`](plugins/design-patterns-kotlin/skills/gof-kotlin-idioms/SKILL.md) — pattern → idiomatic Kotlin, with explicit "when the language supersedes the pattern" callouts

### `kotlin-patterns` (11 skills)

**Mode:**

- [`kp-identify`](plugins/kotlin-patterns/skills/kp-identify/SKILL.md) — diagnostic: which Kotlin-specific pattern fits?

**Functional:**

- [`kp-sealed-when`](plugins/kotlin-patterns/skills/kp-sealed-when/SKILL.md) — pattern matching via sealed types + exhaustive `when`
- [`kp-higher-order-functions`](plugins/kotlin-patterns/skills/kp-higher-order-functions/SKILL.md) — function types, `inline`, reified

**Coroutines:**

- [`kp-coroutine-scope`](plugins/kotlin-patterns/skills/kp-coroutine-scope/SKILL.md) — scope ownership and lifecycle
- [`kp-launch-vs-async`](plugins/kotlin-patterns/skills/kp-launch-vs-async/SKILL.md) — fire-and-forget vs awaitable
- [`kp-dispatchers`](plugins/kotlin-patterns/skills/kp-dispatchers/SKILL.md) — Default / IO / Main / Unconfined
- [`kp-structured-concurrency`](plugins/kotlin-patterns/skills/kp-structured-concurrency/SKILL.md) — `coroutineScope` vs `supervisorScope`

**Flow:**

- [`kp-flow-cold-vs-hot`](plugins/kotlin-patterns/skills/kp-flow-cold-vs-hot/SKILL.md) — `Flow` / `SharedFlow` / `StateFlow`
- [`kp-flow-operators`](plugins/kotlin-patterns/skills/kp-flow-operators/SKILL.md) — map/filter/flatMap*/combine/debounce/buffer

**DSL & anti-patterns:**

- [`kp-type-safe-builders`](plugins/kotlin-patterns/skills/kp-type-safe-builders/SKILL.md) — lambda-with-receiver, `@DslMarker`
- [`kp-anti-patterns`](plugins/kotlin-patterns/skills/kp-anti-patterns/SKILL.md) — Kotlin-specific code smells catalog

## Installing

### Via the Claude Code plugin marketplace (canonical)

```bash
# Inside Claude Code
/plugin marketplace add yonatankarp/ai-skills-market
/plugin install ddd-core@ai-skills-market
/plugin install ddd-kotlin@ai-skills-market
```

### Via the `skills` CLI (npx, no Claude Code commands)

The community [`vercel-labs/skills`](https://github.com/vercel-labs/skills) CLI installs skills directly from this repo — one skill, a few specific ones, a whole plugin, or everything. It recursively discovers SKILL.md files under `plugins/<plugin>/skills/`, so no special config is needed on the consumer side.

**Browse what's available** (lists all skills in the repo, does not install):

```bash
npx skills add yonatankarp/ai-skills-market -l
```

**Install a single skill:**

```bash
# Global (writes to ~/.claude/skills/)
npx skills add yonatankarp/ai-skills-market --skill ddd-design -g

# Project-level (writes to ./.claude/skills/ in the current directory)
npx skills add yonatankarp/ai-skills-market --skill ddd-design
```

**Install several specific skills** (names space-separated):

```bash
npx skills add yonatankarp/ai-skills-market --skill ddd-aggregate gof-strategy ddd-bounded-context -g
```

**Install a whole plugin** — pass the plugin's path as the source. Only the skills inside that folder are picked up:

```bash
npx skills add yonatankarp/ai-skills-market/plugins/ddd-core --all -g
```

The same shape works for any plugin: `plugins/ddd-kotlin`, `plugins/design-patterns-core`, `plugins/design-patterns-kotlin`, etc.

**Install everything in the marketplace:**

```bash
npx skills add yonatankarp/ai-skills-market --all -g
```

The CLI auto-detects Claude Code as the target agent and writes skills into the right directory.

### Local development

To install from a local clone (e.g., while authoring or contributing):

```bash
/plugin marketplace add ~/Projects/ai-skills-market
```

## How the skills compose

Mode skills are *entry points* triggered by user intent ("help me design a domain", "review this for DDD smells", etc.). They orchestrate, then reference pattern primitive skills.

Pattern primitives are *knowledge units* — one DDD concept each. They define what the pattern is, when to apply it, when not to, and the decisions involved. They never commit to a programming language.

Language adapter plugins like `ddd-kotlin` never duplicate concepts. They translate pattern decisions into idiomatic code for one language.

This means you can install `ddd-core` alone to get DDD guidance in any language, and add `ddd-kotlin` (or future `ddd-typescript`, `ddd-rust`, …) for language-specific scaffolding.

## Repository layout

```
ai-skills-market/
├── .claude-plugin/marketplace.json     # Marketplace definition
├── plugins/
│   ├── ddd-core/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/                     # One folder per skill, each with SKILL.md
│   └── ddd-kotlin/
│       ├── .claude-plugin/plugin.json
│       └── skills/
├── docs/
│   ├── specs/                          # Design specs per major change
│   └── CONTRIBUTING.md                 # Skill authoring conventions
├── references/                         # Shared reference material (book citations, diagrams)
└── README.md
```

## Contributing

See [`docs/CONTRIBUTING.md`](docs/CONTRIBUTING.md) for skill authoring conventions and how to add a new plugin.

## License

[MIT](LICENSE)

## Acknowledgements

The `ddd-core` plugin is grounded in *Domain-Driven Design: Tackling Complexity in the Heart of Software* by Eric Evans (2003). Skills paraphrase and apply Evans's concepts; they do not reproduce the book.
