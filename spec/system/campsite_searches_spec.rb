require 'rails_helper'

RSpec.describe "CampsiteSearches", type: :system do
  let!(:camp1) { create(:campsite, name: "富士山キャンプ場", address: "山梨県富士吉田市") }
  let!(:camp2) { create(:campsite, name: "琵琶湖キャンプ場", address: "滋賀県大津市") }

  before do
    driven_by(:rack_test)
  end

  it "キャンプ場名で検索できる" do
    visit campsites_path
    fill_in "キャンプ場名", with: "富士山"
    click_button "検索"
    expect(page).to have_content "富士山キャンプ場"
    expect(page).not_to have_content "琵琶湖キャンプ場"
  end

  it "住所で検索できる" do
    visit campsites_path
    fill_in "住所", with: "滋賀県"
    click_button "検索"
    expect(page).to have_content "琵琶湖キャンプ場"
    expect(page).not_to have_content "富士山キャンプ場"
  end
end
