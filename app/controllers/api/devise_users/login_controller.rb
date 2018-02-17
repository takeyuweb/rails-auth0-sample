# Devise User の Auth0 へのAutomaticMigration サンプル
# Auth0 へのログインがあった際、未登録の email のとき、こちらへ問い合わせを行う
# Devise のユーザーでパスワードがただしいか確認し、正しければユーザーIDを返す
class Api::DeviseUsers::LoginController < ApplicationController
  # TODO: IPアドレス制限。Auth0のカスタムデータベースアクセスのソースIPアドレスを確認してそこのみ許可する

  def show
    user = User.find_by(email: params[:email])
    if user&.valid_for_authentication? { user.valid_password?(params[:password]) } &&
      user&.active_for_authentication?

      # 認証を通ったらこのデータベースが持っているユーザー情報を返す
      data = {
        user_id: user.id,
        email: user.email
      }
      render json: data
    else
      render status: :not_found, json: {}
    end
  end
end
