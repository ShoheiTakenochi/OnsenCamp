require 'rails_helper'

RSpec.describe "hotsprings", type: :request do
  describe "GET /campsites/:id" do
    let(:campsite) { create(:campsite, latitude: 35.0, longitude: 135.0) }
    let!(:near_hotspring) { create(:hotspring, name: "近場の湯", latitude: 35.05, longitude: 135.05) }
    let!(:far_hotspring) { create(:hotspring, name: "遠すぎの湯", latitude: 36.0, longitude: 136.0) }

    it "10km圏内の温泉だけが表示される" do
      get campsite_path(campsite)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("近場の湯")
      expect(response.body).not_to include("遠すぎの湯")
    end
  end
end 
