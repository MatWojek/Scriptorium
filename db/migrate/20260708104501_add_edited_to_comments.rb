class AddEditedToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :edited, :boolean, default: false, null: false
    add_column :comments, :edited_at, :datetime
  end
end
