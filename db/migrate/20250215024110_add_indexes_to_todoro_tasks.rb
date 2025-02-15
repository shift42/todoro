class AddIndexesToTodoroTasks < ActiveRecord::Migration[8.0]
   def change
    add_index :todoro_task_lists, [:taskable_type, :taskable_id]
    add_index :todoro_tasks, :status
    add_index :todoro_tasks, :expiry_date
  end
end
