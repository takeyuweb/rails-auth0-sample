# rails-auth0-sample

https://rails-auth0-sample.herokuapp.com/

- Use Omniauth

## Lock for Web

https://github.com/takeyuweb/rails-auth0-sample/pull/1

フロントエンドだけで高度な認証を提供できるぽい
UIもウィジェットの他DOMへの埋め込みなどもでき、かなり柔軟にいじれそう

https://rails-auth0-sample.herokuapp.com/auth0js

![auth0-js](https://user-images.githubusercontent.com/60980/36315957-52ac1efa-137c-11e8-9404-066017c72c70.gif)

## Automatic Migration - Deviseで登録したユーザーをAuth0に自動移行する

https://github.com/takeyuweb/rails-auth0-sample/pull/6

既存のDeviseのユーザーを、バッチ処理やパスワードリセットなしに徐々にAuth0に移行していく方法のサンプル。

Auth0ログインのフォールバック先として、既存のサービスのデータベース/APIを利用したパスワード認証が可能。
この機能を利用することで、運用中のサービスをゆるやかにAuth0認証に移行することが可能。

## omniauth-facebook から Auth0 への移行サンプル

https://github.com/takeyuweb/rails-auth0-sample/pull/10

omniauth-facebook でログインした場合、FacebookのユーザーIDが得られ、それをみてユーザーを識別します。
Auth0でFacebookログインを使った場合、Auth0から得られるuidは "facebook|FacebookのユーザーID" となっているため、これを使って移行前のユーザー情報を特定できます。

## Custom Social Extensions - 標準で対応していないソーシャルログインへの対応

https://github.com/takeyuweb/rails-auth0-sample/issues/5

グローバルでないサービス、自前サービスの認証など、Auth0がサポートしているソーシャルログイン以外にも、OAuthに対応していれば Custom Social Extensions で対応可能。

上記サンプルでは Yahoo! ID連携 をAuth0で使う方法を調べた。

