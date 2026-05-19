---
name: kp-flow-operators
description: Use when transforming, combining, or controlling backpressure on a Kotlin Flow — phrases like "flow operators", "map filter on flow", "flatMapConcat vs flatMapMerge vs flatMapLatest", "debounce", "combine zip flows", "buffer conflate sample", "flow backpressure", "distinctUntilChanged". Catalogs the most-used Flow operators by purpose: shape, combine, time, backpressure.
---

## One-line summary

Catalog of Kotlin Flow operators by purpose — transformations, combinations, time-based controls, and backpressure tools — with picking criteria for the choices that bite (especially `flatMap*` variants).

## When to use this skill

- Composing a Flow pipeline (`map`, `filter`, `transform`, `scan`).
- Combining multiple flows into one.
- Time-based stream control (debouncing, sampling, throttling).
- The producer emits faster than the collector can consume — backpressure controls.

## When NOT to use this skill

- The stream is a bounded list — use `Iterable`/`Sequence` operators.
- A single async value — use `Deferred` or `suspend fun`.

## Core content

**Shape — transform a single flow.**

- **`map { … }`** — synchronous transform.
- **`filter { … }`** — drop emissions failing a predicate.
- **`transform { emit(...) }`** — emit zero or many values per input.
- **`scan(initial) { acc, v -> … }`** — running fold; emits each intermediate accumulator.
- **`distinctUntilChanged()`** — drop emissions equal to the previous one.
- **`take(n)` / `drop(n)`** — limit / skip the prefix.

**Combine — merge multiple flows.**

- **`combine(a, b) { … }`** — emit a new value each time *any* upstream emits, using the latest from each. Common for combining UI state slices.
- **`zip(a, b) { … }`** — emit only when both upstream have emitted; pair them positionally. Stops when either completes.
- **`merge(a, b)`** — interleave emissions from multiple flows in the order they arrive.

**Async transforms — `flatMap*` family.** The most consequential picking decision in the Flow API.

- **`flatMapConcat { v -> innerFlow(v) }`** — process one inner flow at a time, in order. Slowest, deterministic.
- **`flatMapMerge { v -> innerFlow(v) }`** — process inner flows concurrently. Order not guaranteed. Use with caution; concurrency can explode.
- **`flatMapLatest { v -> innerFlow(v) }`** — when a new upstream value arrives, cancel the current inner flow and start over. Use for "search-as-you-type" — only the latest query matters.

```kotlin
queryInput
    .debounce(300.milliseconds)
    .distinctUntilChanged()
    .flatMapLatest { query -> repository.search(query) }
    .collect { results -> render(results) }
```

**Time-based controls.**

- **`debounce(d)`** — emit only after `d` of quiet (no new emissions). Use for search-as-you-type, button-click flood control.
- **`sample(d)`** — emit the latest value every `d` (regardless of how many were emitted).
- **`throttleFirst(d)`** — emit the first value in each window of length `d`, drop the rest.
- **`timeout(d)`** — fail if no value arrives within `d`.

**Backpressure — when producer outpaces consumer.**

- **`buffer(capacity = N)`** — decouple producer and consumer with a bounded buffer. Producer can keep emitting while consumer catches up.
- **`conflate()`** — replace pending value with the newest. Use when only the latest matters (UI state, sensor readings).
- **`sample(d)`** — time-based variant of conflate; emit at most once per `d`.

## Decision heuristics

- For "search-as-you-type", combine `debounce` + `distinctUntilChanged` + `flatMapLatest`.
- For UI state assembled from multiple flows, use `combine`.
- For positional pairing (two streams that emit in lock-step), use `zip`.
- For concurrent inner work where order doesn't matter, `flatMapMerge` with explicit concurrency parameter.
- When unsure between `flatMapConcat` / `flatMapMerge` / `flatMapLatest`, default to the most restrictive one (`flatMapConcat`) and relax only if needed.

## Anti-patterns

- `flatMapMerge` with unbounded concurrency on an unbounded upstream — can launch thousands of concurrent operations.
- `flatMapLatest` where every inner result actually matters — silently drops results when upstream emits faster than inner completes.
- Long pipelines without `flowOn` — every operator runs on the consumer's dispatcher; expensive transforms starve it. Use `flowOn(Dispatchers.Default)` to move upstream work to a CPU dispatcher.
- Collecting the same Flow multiple times for the same data — for cold flows, this means doing the work twice. Use `shareIn` / `stateIn` to convert to a shared flow.

## See also

- `kp-flow-cold-vs-hot` — picking the right Flow variant.
- `gof-kotlin-idioms` — Flow operators are referenced in the Observer treatment there too.

## References

- *Kotlin Design Patterns and Best Practices* (Alexey Soshin), Ch. 7 (Controlling the Data Flow).
- Kotlin coroutines official guide — Flow, asynchronous operations, buffering.
