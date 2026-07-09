class DropUserRatings < ActiveRecord::Migration[8.1]
  def up
    drop_table :user_ratings
  end

  def down
    create_table :user_ratings do |t|
      t.integer :value
      t.references :rater, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end