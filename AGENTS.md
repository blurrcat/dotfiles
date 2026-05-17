# AGENT.md

As a software engineer, this is what I do fundamentally.

1. Solve problems using computers.
2. Control complexity while solving those problems.

## Complexity

Complexity is the enemy.

Use "no" against unnecessary features and unnecessary abstractions. When compromise is needed, prefer an 80/20 solution: most of the value with much less code.

## Factoring

Do not factor too early. Early in a project, the system has not yet taken shape.

Wait for good cut-points to emerge. A good cut-point has a narrow interface with the rest of the system: a small number of functions or abstractions that hide internal complexity.

Prototype early, especially when ideas are abstract. Prefer working code and demos over large up-front abstractions.

## Testing

Tests are important, but tests should follow understanding.

Prefer testing along the way. After the prototype phase, be disciplined about adding tests.

Favor integration tests around stable cut-points: high-level enough to test system correctness, low-level enough to debug.

Use unit tests when useful, especially early, but do not get attached to tests that mirror implementation details.

Keep a small, working end-to-end test suite for common flows and important edge cases.

When fixing a bug, first reproduce it with a regression test, then fix it.

Avoid mocking unless necessary; when used, prefer coarse-grained mocking around cut-points or systems.

## Refactoring

Refactoring is often good after code has firmed up.

Keep refactors small. Ideally the system works throughout the refactor, and each step is finished before the next begins.

Before removing or rewriting existing code, understand why it exists. Respect code that works today, even when it is ugly.

## Readability

Prefer code that is easy to debug over code that minimizes lines.

Break complex expressions into named intermediate values when that makes behaviour easier to inspect.

## DRY

DRY is useful, but balance it.

Simple, obvious repetition can be better than a complex abstraction made only to remove duplication.

## Locality of Behaviour

The behaviour of a unit of code should be as obvious as possible by looking only at that unit of code.

Prefer putting behaviour on or near the thing that does the thing.

Avoid “spooky action at a distance”: behaviour spread across distant files or hidden behind indirect wiring.

Distinguish between surfacing behaviour and inlining implementation. A good abstraction may hide implementation while keeping invocation obvious.

LoB conflicts with DRY and Separation of Concerns. Make tradeoffs deliberately. The farther behaviour is from the code unit it affects, the worse the locality violation.

## Logging

Log major logical branches.

When a request spans multiple machines, include a request ID so logs can be grouped.

Prefer logging systems where log level can be controlled dynamically, and ideally per user.

## Concurrency

Fear concurrency.

Prefer simple concurrency models: stateless web request handlers and simple remote job worker queues where jobs are independent and APIs are simple.

## Optimization

Do not optimize without a concrete real-world performance profile showing a specific issue.

Do not assume CPU is the problem. Network calls are expensive and should be minimized where practical.

## APIs

Good APIs do not make the caller think too much.

Design simple APIs for simple cases. Make complex cases possible with more complex APIs, layered behind the simple path.

Put common operations on the thing people already have.
