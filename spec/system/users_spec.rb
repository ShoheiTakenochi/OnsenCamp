require "rails_helper"

RSpec.describe "Users", type: :system do
  include LoginMacros
  let(:user) { build(:user, username: "サンプル太郎", email: "rantekun@example.com", password: "password") }
  let(:registereduser) { create(:user, email: "rantekunrobo@example.com", password: "password") }
  let(:edituser) { create(:user, email: "rantekunV2@example.com", password: "password") }

  before do
    driven_by(:rack_test)
  end

  describe "ログイン前" do
    context "ユーザーの新規登録" do
      it "フォームの入力値が正常" do
        visit new_user_registration_path
        fill_in "ユーザーネーム", with: user.username
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        fill_in "パスワード確認", with: "password"
        click_button "登録する"
        expect(page).to have_content "ようこそ！アカウント登録が完了しました。"
        expect(current_path).to eq root_path
      end

      it "メールアドレスが未入力" do
        visit new_user_registration_path
        fill_in "ユーザーネーム", with: user.username
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: "password"
        fill_in "パスワード確認", with: "password"
        click_button "登録する"
        expect(page).to have_content "Emailを入力してください"
        expect(current_path).to eq "/users"
      end

      it "登録済のメールアドレスを入力する" do
        visit new_user_registration_path
        fill_in "ユーザーネーム", with: user.username
        fill_in "メールアドレス", with: registereduser.email
        fill_in "パスワード", with: "password"
        fill_in "パスワード確認", with: "password"
        click_button "登録する"
        expect(page).to have_content "Emailはすでに存在します"
        expect(current_path).to eq "/users"
      end

      it "マイページ遷移" do
        visit edit_user_registration_path 
        expect(page).to have_content "サインインまたは登録が必要です。"
        expect(current_path).to eq user_session_path
      end
    end
  end

  describe "ログイン後" do
    context "ユーザー編集" do
      it "フォームの入力値が正常" do
        login(registereduser)
        visit edit_user_registration_path
        fill_in "メールアドレス", with: user.email
        fill_in "現在のパスワード（必須）", with: "password"
        click_button "commit"
        expect(page).to have_content "アカウント情報が更新されました。"
        expect(current_path).to eq root_path
      end

      it "メールアドレスが未入力の場合エラーになる" do
        login(registereduser)
        visit edit_user_registration_path
        fill_in "メールアドレス", with: ""
        fill_in "現在のパスワード（必須）", with: "password"
        click_button "commit"
        expect(page).to have_content "Emailは不正な値です"
        expect(current_path).to eq "/users"
      end

      it "登録済みのメールアドレスを入力する " do
        login(registereduser)
        visit edit_user_registration_path
        fill_in "メールアドレス", with: edituser.email
        fill_in "現在のパスワード（必須）", with: "password"
        click_button "commit"
        expect(page).to have_content "Emailはすでに存在します"
        expect(current_path).to eq "/users"
      end
    end
    context "お気にいりページ遷移" do
      it "お気にいりページに遷移する" do
        login(registereduser)
        visit favorites_path
        expect(current_path).to eq favorites_path
        expect(page).to have_content "Favorite"
      end
    end
  end
end
