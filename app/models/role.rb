class Role < ApplicationRecord
  has_many :users

  def translated_name
    I18n.t("roles.#{code}", default: name)
  end

  def label_with_description
    description.present? ? "#{name} — #{description}" : name
  end
end
