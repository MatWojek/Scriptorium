class AddUniqueIndexesToUsers < ActiveRecord::Migration[8.1]
  def change
    add_index :users, "LOWER(email)", unique: true, name: "index_users_on_lower_email"
    add_index :users, "LOWER(username)", unique: true, name: "index_users_on_lower_username"
  end
end
