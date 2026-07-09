class CommentRating < ApplicationRecord
  belongs_to :rater, class_name: "User"
  belongs_to :comment
  
  validates :value, inclusion: { in: [1, -1] }
  validates :rater_id, uniqueness: { scope: :comment_id }
end
