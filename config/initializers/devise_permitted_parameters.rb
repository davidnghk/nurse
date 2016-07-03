module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :name
    # devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :name, :email, :phone_no, 
        :password, :password_confirmation, :role, :qualification, 
        :registration_no, :registration_chinese_name, 
        :registration_english_name, :registration_expiry_date, 
        :image_file_name, 
        :hkid_image_file_name, 
        :certicate_image_file_name, 
        :status, :bank, :bank_account_no, :bank_account_name )
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({ roles: [] }, :name, :email, :phone_no, 
        :password, :password_confirmation, :role, :qualification, 
        :registration_no, :registration_chinese_name, 
        :registration_english_name, :registration_expiry_date, 
        :image_file_name, 
        :hkid_image_file_name,
        :certicate_image_file_name,
        :status, :bank, :bank_account_no, :bank_account_name,
        :current_password)
    end
  end

end

DeviseController.send :include, DevisePermittedParameters
