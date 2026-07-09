class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.string :icon

      t.timestamps
    end
  end
end
