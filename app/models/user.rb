class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      added_attrs = [ :username, :email, :password, :password_confirmation ]
      devise_paramater_sanitizer.permit :sign_up, keys: added_attrs
      devise_paramater_sanitizer.permit :account_update, keys: added_attrs
      devise_paramater_sanitizer.permit :sign_in, keys: added_attrs
    end
end
