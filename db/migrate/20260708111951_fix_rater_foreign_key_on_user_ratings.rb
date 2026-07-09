class FixRaterForeignKeyOnUserRatings < ActiveRecord::Migration[8.1]
  def change
    remove_reference :user_ratings, :rater, foreign_key: true
    add_reference :user_ratings, :rater, foreign_key: { to_table: :users }
  end
end
