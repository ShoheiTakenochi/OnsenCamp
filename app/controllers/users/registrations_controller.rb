class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  def create
    super
  end

  def destroy
    super
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.provider.present?
      # 🔥 current_password を除いたパラメータだけで更新
      result = resource.update_without_password(account_update_params.except(:current_password))
    else
      result = update_resource(resource, account_update_params)
    end

    if result
      set_flash_message :notice, :updated if is_flashing_format?
      bypass_sign_in resource, scope: resource_name
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :email, :profile_image ])
  end
end
