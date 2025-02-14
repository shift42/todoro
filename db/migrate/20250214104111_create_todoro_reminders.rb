class CreateTodoroReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :todoro_reminders do |t|
      t.references :task, null: false, foreign_key: { to_table: :todoro_tasks }
      t.datetime :remind_at, null: false  # Enforce remind_at is mandatory



      t.timestamps
    end
  end
end
