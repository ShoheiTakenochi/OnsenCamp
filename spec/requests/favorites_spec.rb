require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:campsite) { create(:campsite) }

  before do
    sign_in user
  end

  describe "POST /favorites" do
    it "お気に入り登録できる" do
      expect {
        post campsite_favorite_path(campsite_id: campsite.id)
      }.to change(Favorite, :count).by(1)

      expect(response).to have_http_status(:found) # or :found depending on redirect status
      follow_redirect!
      expect(response.body).to include("お気に入りに追加しました。")
    end
  end

  describe "DELETE /favorites/:id" do
    let!(:favorite) { create(:favorite, user: user, campsite: campsite) }

    it "お気に入り解除できる" do
      expect {
        delete campsite_favorite_path(campsite_id: favorite.campsite.id, id: favorite.id)
      }.to change(Favorite, :count).by(-1)

      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response.body).to include("お気に入りを解除しました。")
    end
  end

  describe "GET /favorites" do
    let!(:favorite) { create(:favorite, user: user, campsite: campsite) }

    it "お気に入り一覧が表示される" do
      get favorites_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(campsite.name)
    end
  end
end
