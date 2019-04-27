Rails.application.routes.draw do

  post 'user_token' => 'user_token#create'
  devise_for :users
  root to: 'pages#home'

  # --- Create
  get '/spots/new', to: 'spots#new', as: :new_spot
  post '/spots', to: 'spots#create'

  # --- Read
  get '/spots', to: 'spots#index'
  get '/spots/:id', to: 'spots#show', as: :spot

  # --- Edit
  get '/spots/:id/edit', to: 'spots#edit', as: :edit_spot
  patch '/spots/:id', to: 'spots#update'

  # --- Delete
  delete '/spots/:id', to: 'spots#destroy', as: :destroy

  # --- Posts
  post '/spots/:spot_id/posts', to: 'posts#create', as: :spot_posts

  # --- Api
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [ :update, :create ]
      resources :spots, only: [ :index, :show, :update, :create, :destroy ]
    end
  end

end
