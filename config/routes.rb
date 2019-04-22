Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
