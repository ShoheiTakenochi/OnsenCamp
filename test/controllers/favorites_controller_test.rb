require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # 例: テストユーザーをセットアップ
    @campsite = campsites(:one) # 例: テストキャンプ場をセットアップ
    sign_in @user # deviseのヘルパーメソッドでログイン
  end

  test "should post create" do
    post campsite_favorite_path(@campsite)
    assert_response :redirect # または :success など、期待されるレスポンス
  end

  test "should delete destroy" do
    delete campsite_favorite_path(@campsite)
    assert_response :redirect # または :success など、期待されるレスポンス
  end
end
