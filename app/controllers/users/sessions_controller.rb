class Users::SessionsController < Devise::SessionsController

  def destroy
    super
    flash[:alert] = "ログアウトしました"
  end

  protected

  # ログイン後のリダイレクト先を変更
  def after_sign_in_path_for(resource)
    root_path  # ユーザーのマイページにリダイレクト
  end

  # ログアウト後のリダイレクト先を変更
  def after_sign_out_path_for(resource_or_scope)
    root_path  # トップページにリダイレクト
  end
end
