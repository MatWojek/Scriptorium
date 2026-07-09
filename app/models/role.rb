class Role < ApplicationRecord
  has_many :users

  def label_with_description
    description.present? ? "#{name} — #{description}" : name
  end
end
