class DeviseUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
    devise_user_id = uid.to_s.match(/\Adevise_user|(\d+)$/)&.captures&.first
    find_by(id: devise_user_id)
  end
end
