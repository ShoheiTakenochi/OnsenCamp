namespace :fetch do
  desc "Fetch and save hotsprings from OpenStreetMap Overpass API"
  task hotsprings: :environment do
    puts "♨️ 温泉データを取得中..."

    hotsprings = OverpassService.fetch_hotsprings_with_images

    hotsprings.each do |data|
      begin
        Hotspring.find_or_create_by!(
          name: data["tags"]["name"] || "不明",
          address: data["tags"].key?("addr:full") ? data["tags"]["addr:full"] : "住所不明",
          latitude: data["lat"],
          longitude: data["lon"],
          parking: data["tags"]["parking"] == "yes",
          sauna: data["tags"]["sauna"] == "yes",
          open_air_bath: data["tags"]["open_air_bath"] == "yes",
          photo_url: data["tags"]["image"] || data["tags"]["wikimedia_commons"]
        )
      rescue => e
        puts "❌ 温泉データ保存エラー: #{e.message}"
        Rails.logger.error "温泉データ保存エラー: #{e.message}"
      end
    end

    puts "✅ 温泉データの取得＆保存が完了しました！"
  end
end