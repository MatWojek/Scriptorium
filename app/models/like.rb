class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :value, inclusion: {in: [1, -1]}
  validates :user_id, uniqueness: { scope: :article_id }
end
