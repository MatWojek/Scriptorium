class CreateUserRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :user_ratings do |t|
      t.integer :value
      t.references :rater, foreign_key: { to_table: true } 
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :user_ratings, [:rater_id, :user_id], unique: true
  end
end
