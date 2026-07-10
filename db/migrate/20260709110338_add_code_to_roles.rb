class AddCodeToRoles < ActiveRecord::Migration[8.1]
  def change
    add_column :roles, :code, :string
  end
end
