module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_omniauth?
  end

  def authenticate_omniauth?
    redirect_to '/' unless logged_in_using_omniauth?
  end

  # 現在 Auth0 でログインしたユーザーがDeviseからAuth0のAutomatic Migration機能で移行したユーザーの場合、
  # 対応する DeviseUser を取り出す
  def devise_user
    return @devise_user if defined?(@devise_user)
    @devise_user = if logged_in_using_omniauth?
                     provider = session[:userinfo]['provider']
                     if provider == 'auth0'
                       uid = session[:userinfo]['uid'] # ex) "auth0|5a84413df5c8213cb27be6cd" or "auth0|DeviseUser:1"
                       stripped_uid = uid.sub("#{provider}|", '')
                       DeviseUser.find_by_auth0_uid(stripped_uid)
                     end
                   end
  end

  def logged_in_using_omniauth?
    session[:userinfo].present?
  end

end
