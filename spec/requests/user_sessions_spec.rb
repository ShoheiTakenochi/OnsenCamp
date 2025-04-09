require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  describe "ユーザー登録" do
    let(:valid_params) do
      {
        user: {
          username: "テストユーザー",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          username: "",
          email: "invalid",
          password: "short",
          password_confirmation: "mismatch"
        }
      }
    end

    it "有効なデータで登録できる" do
      post user_registration_path, params: valid_params
      expect(response).to have_http_status(:see_other)
      follow_redirect!
      expect(response.body).to include("ようこそ！アカウント登録が完了しました。")
    end

    it "無効なデータでは登録できない" do
      post user_registration_path, params: invalid_params
      expect(response.body).to include("Emailは不正な値です").or include("メールアドレスは不正な値です") # ロケールに合わせて
    end
  end

  describe "ログインとログアウト" do
    let!(:user) { create(:user, email: "loginuser@example.com", password: "password") }

    context "ログイン" do
      it "正しい情報でログインできる" do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: "password"
          }
        }
        expect(response).to have_http_status(:see_other)
        follow_redirect!
        expect(response.body).to include("サインインしました。")
      end

      it "誤った情報ではログインできない" do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: "wrongpass"
          }
        }
        expect(response.body).to include("Emailまたはパスワードが不正です。")
      end
    end

    context "ログアウト" do
      it "ログアウトできる" do
        sign_in user
        delete destroy_user_session_path
        follow_redirect!
        expect(response.body).to include("サインアウトしました。")
      end
    end
  end
end
