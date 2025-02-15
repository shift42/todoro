class CreateProjects < ActiveRecord::Migration[ActiveRecord::Migration.current_version]
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
