class AddAdminToUsers < ActiveRecord::Migration[8.1]
  def change
    # To change permission 
    # bin/rails c
    # User.find_by(username:"Admin").update(admin:true)
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
