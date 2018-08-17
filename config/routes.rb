Rails.application.routes.draw do

  namespace :api do
    resources :users, param: :username
    get 'check_email_avail', to: 'users#check_email_avail'
    get 'check_username_avail', to: 'users#check_username_avail'
    resources :monsters
    post 'user_token', to: 'user_token#create'
    get 'current_user_info', to: 'current_user#current_user_info'
  end

end
