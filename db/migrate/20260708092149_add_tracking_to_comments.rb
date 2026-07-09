class AddTrackingToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :ip_address, :string
  end
end
