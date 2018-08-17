class Api::UserTokenController < Knock::AuthTokenController
  def auth_params
    auth_params = params.require(:auth).permit :email, :password
    auth_params[:email].downcase!
    auth_params
  end
end
