FactoryBot.define do
  factory :user do
    username { "サンプル太郎" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    # Deviseのテストで有効にするため
    after(:build) { |user| user.skip_confirmation! if user.respond_to?(:skip_confirmation!) }
  end
end
