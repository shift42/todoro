# This migration comes from todoro (originally 20250217155125)
class CreateTaskAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :todoro_task_assignments do |t|
      t.references :task, null: false, foreign_key: { to_table: :todoro_tasks }
      t.references :assignee, polymorphic: true, null: false

      t.timestamps
    end
  end
end
