Rails.application.routes.draw do

  namespace :api do
    resources :users, param: :username
    resources :monsters
    post 'user_token', to: 'user_token#create'
    get 'current_user_info', to: 'current_user#current_user_info'
  end

end
