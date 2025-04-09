FactoryBot.define do
  factory :favorite do
    association :user
    association :campsite
  end
end
