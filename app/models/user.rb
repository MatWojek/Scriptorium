class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_secure_password
  has_one_attached :avatar

  belongs_to :language, optional: true
  belongs_to :role, optional: true

  has_many :articles, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :comment_ratings,
         class_name: "CommentRating",
         foreign_key: :rater_id,
         dependent: :destroy


  validate :avatar_is_image, if: -> {avatar.attached?}

  validates :email, presence: true, uniqueness: true,
          format: { with: EMAIL_REGEX, message: "must be a valid email address" }

  validates :email, presence: true,
            uniqueness: { case_sensitive: false, message: "is already registered" },
            format: { with: EMAIL_REGEX, message: "must be a valid email address" }

  validates :username, presence: true,
  uniqueness: { case_sensitive: false, message: "is already taken" }

  validates :password, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9\s]).{8,}\z/,
    message: "must include uppercase, lowercase, a number, and a symbol"
  }, if: -> { password.present? }

  # Averange score of all write comments
  def reputation
    scored_comments = comments.joins(:ratings)
    return 0.0 if scored_comments.none?

    total = CommentRating.joins(:comment).where(comments: { user_id: id }).sum(:value)
    count = comments.count

    (total.to_f / count).round(2)
  end
  
  def admin? 
    admin
  end 

  private

  def avatar_is_image
    return unless avatar.attached?

    unless avatar.content_type.in?(%w[image/png image/jpeg image/webp])
      errors.add(:avatar, "must be a PNG, JPG or WEBP image")
    end
    if avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "must be smaller than 5MB")
    end
  end 
end
