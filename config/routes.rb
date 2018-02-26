Rails.application.routes.draw do
  namespace :api do
    namespace :devise_users do
      get 'login' => 'login#show', module: :devise_users
      get 'get_user' => 'get_user#show', module: :devise_users
    end
  end

  get '/devise_sample' =>  'devise_sample#show'

  devise_for :devise_users, controllers: { omniauth_callbacks: 'devise_users/omniauth_callbacks' }
  get 'dashboard' => 'dashboard#show'
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth0js' => 'auth0js#show'
  root 'home#show'
end
