require "open-uri"

class Campsite < ApplicationRecord
  include DistanceCalculatable
  has_many_attached :images
  has_many :hotsprings
  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # 🔹 Ransackの検索可能属性を明示的に指定
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "address", "latitude", "longitude", "photo_paths", "created_at", "updated_at" ]
  end

  # 指定したキャンプ場から10km以内の温浴施設を取得
  def nearby_hotsprings(radius_km = 10)
    Hotspring.all.map do |hotspring|
      distance = haversine_distance(latitude, longitude, hotspring.latitude, hotspring.longitude)
      { hotspring: hotspring, distance: distance } if distance <= radius_km
    end.compact.sort_by { |data| data[:distance] }
  end
end
