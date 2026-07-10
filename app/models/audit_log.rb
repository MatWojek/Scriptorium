class AuditLog < ApplicationRecord
  belongs_to :user, optional: true

  def self.record(action:, user: nil, target: nil, ip: nil, details: nil)
    create(
      action: action,
      user: user,
      target_type: target&.class&.name,
      target_id: target&.id,
      ip_address: ip,
      details: details
    )
  end
end