# This migration comes from todoro (originally 20250217003216)
class CreateTodoroTasks < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :todoro_tasks do |t|
      t.string :title
      t.text :description, null: false  # Description is required
      t.datetime :expiry_date
      t.string :status, null: false, default: "pending"  # Status is required
      t.references :task_list, null: false, foreign_key: { to_table: :todoro_task_lists }

      t.timestamps
    end

    # Enforce status constraint
    execute <<-SQL
      ALTER TABLE todoro_tasks
      ADD CONSTRAINT status_check
      CHECK (status IN ('pending', 'completed'));
    SQL
  end
end
