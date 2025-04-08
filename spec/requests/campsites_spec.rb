require 'rails_helper'

RSpec.describe "Campsites", type: :request do
  describe "GET /campsites" do
    it "一覧ページが表示される" do
      get campsites_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("キャンプ場") # 表示されている文言など
    end
  end

  describe "GET /campsites/:id" do
    let(:campsite) { create(:campsite) }

    it "詳細ページが表示される" do
      get campsite_path(campsite)
      expect(response).to have_http_status(200)
      expect(response.body).to include(campsite.name)
    end
  end
end