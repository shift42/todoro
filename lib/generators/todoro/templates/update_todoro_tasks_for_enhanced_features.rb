class UpdateTodoroTasksForEnhancedFeatures < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    change_table :todoro_tasks do |t|
      t.integer :priority, default: 1, null: false
      t.integer :recurrence_pattern, default: nil # 0: Daily, 1: Weekly, 2: Monthly, 3: Yearly
      t.datetime :completed_at
    end

    rename_column :todoro_tasks, :expiry_date, :due_date
    change_column_null :todoro_tasks, :description, true 


    execute <<-SQL
      ALTER TABLE todoro_tasks
      ADD CONSTRAINT priority_check
      CHECK (priority IN (0, 1, 2));
    SQL

    # Add constraint for recurrence pattern
    execute <<-SQL
      ALTER TABLE todoro_tasks
      ADD CONSTRAINT recurrence_check
      CHECK (recurrence_pattern IN (0, 1, 2, 3) OR recurrence_pattern IS NULL);
    SQL
  end
end
