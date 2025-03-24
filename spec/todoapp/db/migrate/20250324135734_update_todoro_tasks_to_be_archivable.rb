class UpdateTodoroTasksToBeArchivable < ActiveRecord::Migration[7.2]
  def change
    add_column :todoro_tasks, :archived_at, :datetime, default: nil
    add_index :todoro_tasks, :archived_at
  end

  # Enforce status constraint
  execute <<-SQL
    ALTER TABLE todoro_tasks DROP CONSTRAINT status_check;
    ALTER TABLE todoro_tasks
    ADD CONSTRAINT status_check
    CHECK (status IN ('pending', 'completed', 'archived'));
  SQL
end
