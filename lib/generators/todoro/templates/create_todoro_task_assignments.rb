class CreateTodoroTaskAssignments < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :todoro_task_assignments do |t|
      t.references :task, null: false, foreign_key: { to_table: :todoro_tasks }
      t.references :assignee, polymorphic: true, null: false

      t.timestamps
    end
  end
end
