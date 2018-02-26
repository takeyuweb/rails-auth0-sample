class DeviseUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @devise_user = DeviseUser.from_omniauth(request.env['omniauth.auth'])

    sign_in_and_redirect @devise_user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end

  private

  def after_sign_in_path_for(_resource)
    devise_sample_path
  end
end
