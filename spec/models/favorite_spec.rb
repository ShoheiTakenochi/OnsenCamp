require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    it "userがnilの場合は無効であること" do
      favorite = build(:favorite, user: nil)
      expect(favorite).to be_invalid
    end

    it "campsiteがnilの場合は無効であること" do
      favorite = build(:favorite, campsite: nil)
      expect(favorite).to be_invalid
    end

    it "同じユーザーが同じキャンプ場を複数回お気に入りできないこと" do
      user = create(:user)
      campsite = create(:campsite)
      create(:favorite, user: user, campsite: campsite)
      duplicate_favorite = build(:favorite, user: user, campsite: campsite)
      expect(duplicate_favorite).to be_invalid
      expect(duplicate_favorite.errors[:user_id]).to include("はすでに存在します")
    end
  end
end
