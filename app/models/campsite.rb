require "open-uri"

class Campsite < ApplicationRecord
  include DistanceCalculatable
  has_many_attached :images
  has_many :hotsprings, through: :hotspring_campsite_relationships
  has_many :favorite, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user

  before_save :fetch_photo_url, if: -> { photo_paths.blank? && photo_paths.present? }

  attribute :photo_paths, :string
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

  private

   def fetch_photo_url
    return if photo_paths.blank?

    photo_reference = JSON.parse(photo_paths).first rescue nil
    return if photo_reference.blank?

    photo_url = "https://places.googleapis.com/v1/#{photo_reference}/media?maxHeightPx=400&maxWidthPx=400&key=#{ENV['GOOGLE_MAPS_API_KEY']}"

    file = URI.open(photo_url)
    filename = "campsite_#{id}.jpg"

    # 🔹 ActiveStorage に画像を保存
    self.photo.attach(io: file, filename: filename, content_type: "image/jpeg")
  end
end
