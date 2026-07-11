class UpdateTodoroTasksToBeArchivable < ActiveRecord::Migration[7.2]
  def up
    add_column :todoro_tasks, :archived_at, :datetime, default: nil
    add_index  :todoro_tasks, :archived_at

    execute <<-SQL
      ALTER TABLE todoro_tasks DROP CONSTRAINT status_check;
      ALTER TABLE todoro_tasks ADD CONSTRAINT status_check
        CHECK (status IN ('pending', 'completed', 'archived'));
    SQL
  end

  def down
    remove_index  :todoro_tasks, :archived_at
    remove_column :todoro_tasks, :archived_at

    execute <<-SQL
      ALTER TABLE todoro_tasks DROP CONSTRAINT status_check;
      ALTER TABLE todoro_tasks ADD CONSTRAINT status_check
        CHECK (status IN ('pending', 'completed'));
    SQL
  end
end
