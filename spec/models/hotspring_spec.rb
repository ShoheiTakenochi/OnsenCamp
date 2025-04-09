require 'rails_helper'

RSpec.describe Hotspring, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      hotspring = build(:hotspring)
      expect(hotspring).to be_valid
    end

    it "nameがない場合にバリデーションが機能してinvalidになるか" do
      hotspring = build(:hotspring, name: nil)
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:name]).to include("を入力してください")
    end

    it "addressがない場合にバリデーションが機能してinvalidになるか" do
      hotspring = build(:hotspring, address: nil)
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:address]).to include("を入力してください")
    end

    it "latitudeがない場合にバリデーションが機能してinvalidになるか" do
      hotspring = build(:hotspring, latitude: nil)
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:latitude]).to include("を入力してください")
    end

    it "longitudeがない場合にバリデーションが機能してinvalidになるか" do
      hotspring = build(:hotspring, longitude: nil)
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:longitude]).to include("を入力してください")
    end

    it "latitudeが文字列だと無効になること" do
      hotspring = build(:hotspring, latitude: "invalid")
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:latitude]).to include("は数値で入力してください")
    end

    it "longitudeが文字列だと無効になること" do
      hotspring = build(:hotspring, longitude: "invalid")
      expect(hotspring).to be_invalid
      expect(hotspring.errors[:longitude]).to include("は数値で入力してください")
    end
  end
end
