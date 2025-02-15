class CreateTodoroTaskLists < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :todoro_task_lists do |t|
      t.string :name, null: false
      t.references :taskable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
