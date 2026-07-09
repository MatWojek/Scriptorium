class CreateCommentRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :comment_ratings do |t|
      t.integer :value
      t.references :rater, null: false, foreign_key: { to_table: :users }
      t.references :comment, null: false, foreign_key: true
      t.timestamps
    end
    add_index :comment_ratings, [:rater_id, :comment_id], unique: true
  end
end