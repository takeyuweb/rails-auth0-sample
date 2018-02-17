# Devise User の Auth0 へのAutomaticMigration サンプル
# Auth0 からの email と合わせに対してユーザーの有無を調べる
class Api::DeviseUsers::GetUserController < ApplicationController
  # TODO: IPアドレス制限。Auth0のカスタムデータベースアクセスのソースIPアドレスを確認してそこのみ許可する

  def show
    user = User.find_by(email: params[:email])
    if user&.active_for_authentication?

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
