class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { maximum: 20 }

end
