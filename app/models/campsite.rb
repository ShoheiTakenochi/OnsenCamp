require "open-uri"

class Campsite < ApplicationRecord
  has_one_attached :photo

  before_save :fetch_photo_url, if: -> { photo_paths.blank? && photo_paths.present? }

  attribute :photo_paths, :string
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # 🔹 Ransackの検索可能属性を明示的に指定
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "address", "latitude", "longitude", "description", "photo_paths", "created_at", "updated_at" ]
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
