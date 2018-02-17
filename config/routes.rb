Rails.application.routes.draw do
  get '/devise_sample' =>  'devise_sample#show'

  devise_for :users
  get 'dashboard' => 'dashboard#show'
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth0js' => 'auth0js#show'
  root 'home#show'
end
