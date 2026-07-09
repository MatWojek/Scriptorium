class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  has_many :ratings, class_name: "CommentRating", dependent: :destroy
  validates :content, presence: true
  before_update :mark_as_edited, if: :content_changed?

  def score
    ratings.sum(:value)
  end

  def editable_by?(current_user)
    current_user.present? && (user == current_user || current_user.admin?)
  end

  private

  def mark_as_edited
    self.edited = true
    self.edited_at = Time.current
  end
end