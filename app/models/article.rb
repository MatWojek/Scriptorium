class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_rich_text :content
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  belongs_to :language, optional: true
  after_save :extract_hashtags

  def score
    likes.sum(:value)
  end 

  def editable_by?(user)
    user && user.id == user.id
  end 

  private 

  def extract_hashtags
    return unless content.present?

    plain_text = content.to_plain_text
    found_tags = plain_text.scan(/#([\p{L}0-9_]+)/).flatten.uniq

    self.tags = found_tags.map { |name| Tag.find_or_create_by(name: name.downcase) }
  end
end
