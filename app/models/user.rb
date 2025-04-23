class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_campsites, through: :favorites, source: :campsite

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { maximum: 20 }

  def favorite?(campsite)
    favorite_campsites.include?(campsite)
  end

  def add_favorite(campsite)
    favorite_campsites << campsite unless favorite?(campsite)
  end

  def remove_favorite(campsite)
    favorite_campsites.delete(campsite)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
