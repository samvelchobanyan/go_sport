# CLAUDE.md — go_sport

## 1. Project context

go_sport is a Flutter mobile application — a music and radio streaming app. The architecture follows a layered, feature-based structure: `core/`, `domain/`, `data/`, `features/`, with `shared_widgets/` for cross-feature UI components.

Core stack: Flutter/Dart, Riverpod (state), Freezed (immutability), just_audio + audio_service (playback), Dio (networking), go_router (navigation), FlutterSecureStorage (token persistence).

You (Claude Code) act as the implementation agent in this project. Architectural decisions are guided by a cross-project knowledge base; you must consult it before suggesting structural changes.

---

## 2. Knowledge base location

The Flutter knowledge base lives at: **`C:\knowledge\flutter-kb\`**

This is a separate repository, not part of this project. It contains principles, patterns, decisions, and pitfalls accumulated across Flutter projects. You have read access to it; you do not write into it directly.

When working on this project, you must:
- Read `C:\knowledge\flutter-kb\index.md` to understand what knowledge is available
- Read individual pages when relevant to the current task
- Read `C:\knowledge\flutter-kb\projects\go_sport\` for project-scoped ADRs
- Append candidate entries to `C:\knowledge\flutter-kb\log.md` (continuous capture, see Section 5)

You must not:
- Create new pages in the wiki (only the curator agent does that, during ingest)
- Modify existing pages in the wiki
- Reorganize wiki structure

---

## 3. Six principles

These principles govern how you use the knowledge base. They are not optional.

**Principle 1 — Wiki is a starting point, not a final answer.** For every architectural task or decision, begin by reading the wiki index, then relevant pages. Do not stop at the wiki — reason on top of what it provides.

**Principle 2 — Deviation from the wiki is normal, but always explicit.** If you propose something that diverges from a wiki page, say so out loud. Never silently ignore the wiki. Never blindly follow the wiki when context suggests adaptation.

**Principle 3 — New decisions return to the wiki.** When a discussion produces new knowledge — a new pattern, an ADR-worthy choice, a pitfall worth recording — append a candidate entry to `log.md` of the wiki. Do not write into the wiki itself; only deposit candidates.

**Principle 4 — Respect conditions of applicability.** Every wiki page declares `applies_to`. Before applying a pattern or principle from the wiki, check that the conditions match the current task. If they do not, adapt or skip.

**Principle 5 — Distinguish dogma from heuristic.** Wiki pages declare `severity`: `required`, `recommended`, or `flexible`. Calibrate your deference accordingly:
- `required` — deviation requires strong justification; raise it explicitly
- `recommended` — usually followed, may be adapted with reason
- `flexible` — one of several valid options; choose by context

**Principle 6 — Journal decisions in the moment, do not lose knowledge.** Detect decision events during conversations and immediately log candidates. See Section 5 for the protocol.

---

## 4. Workflow for architectural tasks

When the user gives you a task that touches architecture (new feature, refactoring, structural change, new dependency, etc.), follow this workflow.

### 4.1 Start with the wiki

1. **Read the index.** `C:\knowledge\flutter-kb\index.md`. Identify pages relevant to the task by scanning entries (page name, type, severity, applies_to, one-line description).

2. **Read relevant pages.** For each page that looks applicable, read the full content. Pay attention to:
   - `applies_to` — does this match the current task?
   - `severity` — how obligatory is this?
   - `When NOT to apply` (in patterns) or `When this principle does NOT apply` (in principles) — explicit exclusions

3. **Read project ADRs.** `C:\knowledge\flutter-kb\projects\go_sport\` may contain project-specific decisions relevant to the task. Check them.

### 4.2 Plan the approach

Based on the wiki content and the task, formulate a plan. The plan should:

- Reference specific wiki pages you are applying (e.g., "Following [[platform-service-integration]] pattern")
- Articulate any deviation from the wiki and why (e.g., "Wiki suggests X here, but in this case we want Y because Z")
- Identify project-specific constraints from go_sport ADRs

### 4.3 Communicate before implementing

Present the plan to the user **before** writing code. Include:

- The wiki pages you are applying
- Any deviations and their justification
- Any clarifying questions about scope or requirements

Wait for the user's confirmation before proceeding to implementation. Sam prefers conceptual alignment before code; do not skip this step.

### 4.4 Implement

Once the plan is approved, implement. During implementation, respect:

- The project's existing code style and structure
- Layered architecture (see wiki principles)
- Design system tokens (DSColors, DSSpacing, DSRadius, DSTypography); do not hardcode values
- Riverpod conventions for state management

### 4.5 Capture decisions

At each decision event during the conversation, apply continuous capture (Section 5).

---

## 5. Continuous capture protocol

This is how Principle 6 is implemented in practice.

### 5.1 Detecting a decision event

A decision event is a moment when:

- The user and you agreed on an approach ("ok, let's do it this way")
- You applied an existing wiki pattern as-is
- You adapted an existing wiki pattern for this context
- You formulated a new approach not in the wiki
- You discovered a pitfall — a general trap that could be stepped into again

Decision events happen **during** the conversation, not at the end. They can happen multiple times in one session.

### 5.2 Classifying the candidate

When a decision event occurs, classify it:

- **Routine application** — used an existing wiki pattern without modification. No new knowledge. Mention it in your reply ("applying [[pattern-name]] from wiki") and move on. No log entry needed.

- **ADR candidate** — a choice was made between alternatives with explicit justification. Worth recording.

- **Pattern candidate** — a new or adapted reusable structure emerged. Worth recording.

- **Pitfall candidate** — a general trap was discovered (not project-specific). Worth recording.

- **Project-specific decision** — a decision tied to go_sport that doesn't generalize. Worth recording as a project-scoped ADR.

- **Implementation detail** — concrete code-level choice with no transferable value. No log entry needed.

### 5.3 Splitting decisions into levels

One conversation can produce multiple candidates. Decompose decisions into three levels:

- **Choice of tools / packages / versions** → ADR candidate, often `applies_to: project: go_sport`
- **Architectural pattern / structure** → pattern candidate, often `applies_to: any-flutter-project` or a specific scope
- **Concrete implementation in code** → no wiki entry; lives in code

For example, a discussion about adding a search feature can yield:
- Project ADR: "Search repository extracted as separate feature in go_sport" (`applies_to: project: go_sport`)
- Pattern: "Debounced search controller via Riverpod AsyncNotifier" (`applies_to: any-flutter-project`)
- Code: actual SearchController class — not in wiki

### 5.4 Checking existence

Before logging a candidate, check the wiki index to see if a similar page already exists. Three possible outcomes:

- **Exact match exists** — you are applying an existing pattern. Mention it in your reply, no log entry.
- **Related page exists** — the candidate is an extension or refinement of an existing page. Log it as a candidate with a reference to the related page (so the curator agent can decide whether to update the existing page or create a new one).
- **No match exists** — log it as a new candidate.

### 5.5 Writing the log entry

Append to `C:\knowledge\flutter-kb\log.md` at the end of the file.

**Format:**

```
## [YYYY-MM-DD] candidate | go_sport | <topic>
Type: <pattern | decision | pitfall | principle>
Target applies_to: <any-flutter-project | project: go_sport | other-scope>
What: <one-sentence description of the candidate>
Why interesting: <why this is worth capturing>
Context: <what the conversation was about; brief>
Source: Claude Code session <YYYY-MM-DD>, files involved if relevant
Suggested action: <create new page | update [[existing-page]] | merge with [[existing-page]]>
```

**Example:**

```
## [2026-05-15] candidate | go_sport | navigation
Type: pitfall
Target applies_to: flutter-projects-with-stateful-shell-route
What: showModalBottomSheet from widget inside StatefulShellRoute lands in root Navigator, breaks back-gesture (app exits instead of returning)
Why interesting: general Flutter pitfall, not project-specific; useRootNavigator: true does not fix it
Context: implementing full-screen player launched from mini-player inside main shell; reported on iOS swipe-back
Source: Claude Code session 2026-05-15, files mini_player_widget.dart and main_shell.dart
Suggested action: create new pitfall page
```

### 5.6 Behavior in the conversation

When you append a candidate, mention it briefly in your reply:

> "Logged a pitfall candidate to wiki log: showModalBottomSheet inside StatefulShellRoute. Moving on with the fix."

Do not interrupt the conversation with long explanations. The log entry contains the details; the reply contains a one-line notification.

If no candidate emerges from the decision event, you do not need to mention it. Silence means "no candidate".

---

## 6. Anti-patterns

The following are mistakes you must not make.

**Do not skip reading the wiki for architectural tasks.** Even if you think you know the answer, the wiki may contain project-specific ADRs or pitfalls relevant to the task. Reading the index is cheap; skipping it is expensive when it costs a wrong decision.

**Do not blindly follow the wiki when context suggests adaptation.** The wiki captures general principles; the current task may have specific constraints. Articulate adaptations explicitly.

**Do not silently deviate from the wiki.** If you choose an approach different from a wiki pattern, say so. The user needs to see the deviation to evaluate it.

**Do not write into the wiki.** Only candidate entries in `log.md`. Page creation, page modification, index updates — all are operations of the curator agent, performed in separate sessions in the wiki repository.

**Do not log routine applications as candidates.** Using `[[layered-architecture]]` as-is when building a new feature is not a candidate — it's the normal application of an existing principle. Mention it in reply, do not log it.

**Do not skip the planning step before implementation.** Sam prefers conceptual alignment before code. Present the approach, wait for confirmation, then implement.

**Do not hardcode design values.** Use DSColors, DSSpacing, DSRadius, DSTypography. If you need a value not in the design system, raise it with the user before introducing a hardcoded value.

**Do not invent abstractions speculatively.** Sam pushes back hard on premature abstraction. Add providers, layers, or abstractions only when there is a concrete need. When in doubt, do less.
