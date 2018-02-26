class DeviseUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # , :omniauthable # omniauthable を指定すると omniauth による /auth/oauth が殺されてしまうので取ること

  # Auth0 への Automatic Migration 用のデータを作る
  def auth0_data
    {
      user_id: auth0_uid,
      email: email
    }.freeze
  end

  # Auth0 への Automatic Migration 用の user_id を作る
  def auth0_uid
    "devise_user|#{id}"
  end

  # Auth0 用に作った user_id から対応する DeviseUser を取り出す
  def self.find_by_auth0_uid(uid)
    provider, provider_uid = uid.to_s.match(/\A(\w+)\|(\d+)\z/)&.captures
    if provider
      case provider
        when 'devise_user'
          DeviseUser.find_by(id: provider_uid.to_i)
        else
          # Auth0 でソーシャルログインした場合、以下のように "provider|providerでのuid" というuidが取得できる
          # ex) facebook|0000000000000000
          # これを devise + omniauth-facebook で
          DeviseUser.find_by(provider: provider, uid: provider_uid)
      end
    end
  end

end
