Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  devise_for :users
  root to: 'pages#home'

  # --- Read
  get '/spots', to: 'spots#index'
  get '/spots/:id', to: 'spots#show', as: :spot
  
end
