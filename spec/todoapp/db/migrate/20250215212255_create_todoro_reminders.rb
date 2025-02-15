class CreateTodoroReminders < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :todoro_reminders do |t|
      t.references :task, null: false, foreign_key: { to_table: :todoro_tasks }
      t.datetime :remind_at, null: false  # Enforce remind_at is mandatory



      t.timestamps
    end
  end
end
