class Api::UsersController < ApplicationController
  include ReservedPaths

  before_action :set_user, only: [:show, :likes, :update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users, except: [:email, :password_digest]
  end

  # GET /users/1
  def show
    if @user
      render json: User.user_with_associations(@user)
    else
      render status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      render json: @user, status: :created, location: api_user_path(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def check_email_avail
    if params[:email]
      email = params[:email].downcase
      json = User.find_by(email: email) ? false : true
      render json: json
    else
      render status: :bad_request
    end
  end

  def check_username_avail
    if params[:username]
      def username_avail?
        username = params[:username].downcase
        if User.where('lower(username) = ?', username).first ||
          ReservedPaths.paths.include?(username)
          false
        else
          true
        end
      end
      render json: username_avail?
    else
      render status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(username: params[:username])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
