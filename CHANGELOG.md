# Unreleased

- Bug fix: Update generated routes so that resource root path does not override existing applciation routes
- Add initializer to precompile assets so that main app can load views with Todoro's layout
- Added support for **Task Steps**
- Updated **Tasks**: renamed `expiry_date` to `due_date` and introduced `completed_at`, `priority` and `reccuring_pattern`
- Introduced complete! method in Todoro::Task to set completed_at timestamp and mark tasks as completed.
- Added Todoro::TaskStep model, allowing tasks to have multiple subtasks.
- Integrated Turbo to enable dynamic subtask creation and completion without full-page reloads.
- Introduced `taskable_assignee`, allowing models to register as assignable entities.
- Tasks now support dynamic polymorphic assignments to multiple assignees (e.g., `Employee`, `Role`).
- Automatically generates `has_many` associations in `Todoro::Task` for each registered `taskable_assignee`.

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
