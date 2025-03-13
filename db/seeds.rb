# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Campsite.create!(
  name: "富士山キャンプ場",
  latitude: 35.3606,
  longitude: 138.7274,
  address: "静岡県富士宮市",
  description: "富士山の絶景が楽しめるキャンプ場です。"
)