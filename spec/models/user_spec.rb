require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "emailがない場合にバリデーションが機能してinvalidになるか" do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).to be_invalid
      expect(user_without_email).not_to be_valid
    end

    it "重複したメールアドレスは無効であること" do
      create(:user, email: "duplicate@example.com")
      user = build(:user, email: "duplicate@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it "ユーザー名が20文字以内であること" do
      user = build(:user, username: "a" * 21)
      user.valid?
      expect(user.errors[:username]).to include("は20文字以内で入力してください")
    end
  end
end
