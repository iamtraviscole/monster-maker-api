Rails.application.routes.draw do

  namespace :api do
    resources :users
    resources :monsters
    post 'user_token' => 'user_token#create'
  end

end
