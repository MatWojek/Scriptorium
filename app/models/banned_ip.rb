class BannedIp < ApplicationRecord 
  validates :ip_address, presence: true, uniqueness: true 
end 
