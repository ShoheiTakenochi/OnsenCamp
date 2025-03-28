require "httparty"
require "json"

class OverpassService
  BASE_URL = "https://overpass-api.de/api/interpreter"

  def self.fetch_hotsprings_with_images
    query = <<~QUERY
      [out:json];
      node["amenity"="public_bath"](20.0, 122.0, 46.0, 146.0);
      out;
    QUERY

    response = HTTParty.post(BASE_URL, body: { data: query })

    if response.success?
      hotsprings = JSON.parse(response.body)["elements"]

      # ハングルを含む施設名を除外
      hotsprings.reject do |hot_spring|
        name = hot_spring["tags"]&.fetch("name", "")
        name.match?(/\p{Hangul}/) # ハングルが含まれているかチェック
      end
    else
      Rails.logger.error "Overpass APIエラー: #{response.code} - #{response.message}"
      []
    end
  end
end
