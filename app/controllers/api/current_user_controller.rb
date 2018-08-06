class Api::CurrentUserController < ApplicationController
  before_action :authenticate_user

  def current_user_info
    render json: {
        username: current_user.username,
        email: current_user.email
      }
  end

end
