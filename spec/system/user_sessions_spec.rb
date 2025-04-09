require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  include LoginMacros
  let(:user) { build(:user, username: "サンプル太郎", email: "rantekun@example.com", password: "password") }
  let(:registereduser) { create(:user, email: "rantekunrobo@example.com", password: "password") }
  let(:edituser) { create(:user, email: "rantekunV2@example.com", password: "password") }

  before do
    driven_by(:rack_test)
  end

  context "ログイン処理" do
    it "正しい情報でログインできる" do
      visit new_user_session_path
      fill_in "メールアドレス", with: registereduser.email
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(page).to have_content "サインインしました。"
      expect(current_path).to eq root_path
    end

    it "パスワードが間違っているとログインできない" do
      visit new_user_session_path
      fill_in "メールアドレス", with: registereduser.email
      fill_in "パスワード", with: "wrongpassword"
      click_button "ログイン"
      expect(page).to have_content "Emailまたはパスワードが不正です。"
    end
  end

  context "ログアウト処理" do
    it "ログアウトできる" do
      login(registereduser)
      visit root_path
      click_link "ログアウト"
      expect(page).to have_content "サインアウトしました。"
      expect(current_path).to eq root_path
    end
  end
end
