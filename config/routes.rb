Rails.application.routes.draw do
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  root 'home#show'
end
