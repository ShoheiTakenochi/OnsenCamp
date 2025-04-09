require 'rails_helper'

RSpec.describe Campsite, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      campsite = build(:campsite)
      expect(campsite).to be_valid
      expect(campsite.errors).to be_empty
    end

    it "nameがない場合にバリデーションが機能してinvalidになるか" do
      campsite = build(:campsite, name: nil)
      expect(campsite).to be_invalid
      expect(campsite.errors[:name]).to include("を入力してください")
    end

    it "addressがない場合にバリデーションが機能してinvalidになるか" do
      campsite = build(:campsite, address: nil)
      expect(campsite).to be_invalid
      expect(campsite.errors[:address]).to include("を入力してください")
    end

    it "latitudeがない場合にバリデーションが機能してinvalidになるか" do
      campsite = build(:campsite, latitude: nil)
      expect(campsite).to be_invalid
      expect(campsite.errors[:latitude]).to include("を入力してください")
    end

    it "longitudeがない場合にバリデーションが機能してinvalidになるか" do
      campsite = build(:campsite, longitude: nil)
      expect(campsite).to be_invalid
      expect(campsite.errors[:longitude]).to include("を入力してください")
    end
  end
end
