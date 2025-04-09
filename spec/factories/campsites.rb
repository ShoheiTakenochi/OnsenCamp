FactoryBot.define do
  factory :campsite do
    name { "サンプルキャンプ場" }
    address { "北海道札幌市" }
    latitude { 43.06417 }
    longitude { 141.34694 }
    description { "自然豊かなキャンプ場です。" }
    photo_paths { [ "sample1.jpg", "sample2.jpg" ] }
  end
end
