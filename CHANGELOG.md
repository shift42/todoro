# Unreleased

### 1.0.1 - 2026-07-11

- Relax Rails dependency from `~> 7.2.1` to `>= 7.2.1` to support Rails 8

### 1.0.0 - 2026-07-08

#### Breaking Changes

- **Renamed association**: `taskable_assignee` models no longer expose `.tasks` — use `.assigned_tasks` instead
- **Default scope on `Todoro::Task`**: `Task.all` now excludes archived tasks. Use `Task.with_archived` to include them.

#### New Features

- Added `archive!` method on `Todoro::Task` — sets `status: "archived"` and records `archived_at` timestamp
- Added `archived` status to the `status` enum (valid values: `pending`, `completed`, `archived`)
- Added `with_archived` scope to retrieve all tasks including archived ones
- Added migration template `update_todoro_tasks_to_be_archivable` — adds `archived_at` column and updates the DB status constraint

#### Fixes

- Migration `update_todoro_tasks_to_be_archivable` corrected to use `up`/`down` — `execute` was previously called at class level outside any method

#### Other Changes (previously unreleased from 0.1.5)

- Bug fix: Update generated routes so that resource root path does not override existing application routes
- Add initializer to precompile assets so that main app can load views with Todoro's layout
- Added support for **Task Steps** (`Todoro::TaskStep`)
- Updated **Tasks**: renamed `expiry_date` to `due_date`, introduced `completed_at`, `priority` and `recurring_pattern`
- Introduced `complete!` method to set `completed_at` and mark tasks as completed
- Integrated Turbo for dynamic subtask creation and completion without full-page reloads
- Introduced `taskable_assignee`, allowing models to register as assignable entities
- Tasks support dynamic polymorphic assignments to multiple assignees (e.g. `Employee`, `Role`)
- Automatically generates `has_many` associations in `Todoro::Task` for each registered `taskable_assignee`

### 0.1.5 - 2025-02-16

- Automatic route generation for any model that includes `acts_as_taskable`, eliminating the need for manual route configuration.
- Updated README to document automatic route generation and mounting instructions.
- Updated `set_taskable` method to dynamically extract `taskable_type` from routes instead of requiring it in query parameters.
- Updated task `description` to be non mandatory

### 0.1.1 - 2025-02-14

- Add CHANGELOG.md
- Move Engine code to lib/todoro/engine

### 0.1.0 - 2025-02-14

- Introduced `acts_as_taskable` support for models.
- Associate any model with tasklists
- Tasklists can contain multiple tasks
- Tasks with an expiry date have reminders set automatically one day and one hour before they expire
