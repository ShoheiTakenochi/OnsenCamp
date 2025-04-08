FactoryBot.define do
  factory :hotspring do
    name { "サンプル温泉" }
    address { "北海道登別市" }
    latitude { 42.4122 }
    longitude { 141.1064 }
    parking { true }
    sauna { true }
    open_air_bath { true }
    photo_url { "https://example.com/sample_hotspring.jpg" }
  end
end
