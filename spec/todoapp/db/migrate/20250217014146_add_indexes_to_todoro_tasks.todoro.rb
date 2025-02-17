# This migration comes from todoro (originally 20250217003218)
class AddIndexesToTodoroTasks < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
   def change
    add_index :todoro_task_lists, [ :taskable_type, :taskable_id ]
    add_index :todoro_tasks, :status
    add_index :todoro_tasks, :expiry_date
  end
end
