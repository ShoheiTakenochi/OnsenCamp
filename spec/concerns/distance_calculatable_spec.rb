require 'rails_helper'

RSpec.describe DistanceCalculatable do
  let(:dummy_class) do
    Class.new do
      include DistanceCalculatable
    end.new
  end

  describe "#haversine_distance" do
    it "東京駅と品川駅の距離が約6kmであること" do
      distance = dummy_class.haversine_distance(35.6812, 139.7671, 35.6285, 139.7380)
      expect(distance).to be_within(0.5).of(6.0)
    end

    it "同じ座標同士の距離は0になること" do
      distance = dummy_class.haversine_distance(35.0, 135.0, 35.0, 135.0)
      expect(distance).to eq(0)
    end
  end
end
