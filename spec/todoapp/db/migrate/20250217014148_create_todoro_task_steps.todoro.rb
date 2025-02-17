# This migration comes from todoro (originally 20250217012840)
class CreateTodoroTaskSteps < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :todoro_task_steps do |t|
      t.references :task, null: false, foreign_key: { to_table: :todoro_tasks }
      t.string :title
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
