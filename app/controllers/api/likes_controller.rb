class Api::LikesController < ApplicationController
  before_action :authenticate_user

  def like
    @user = current_user
    puts 'CURRENT USER', @user
    @monster = Monster.find(params[:monster_id])
    @user.likes.create(monster_id: @monster.id)
  end

  def unlike
    @user = current_user
    @like = @user.likes.find_by(monster_id: params[:monster_id])
    @monster = Monster.find(params[:monster_id])
    @like.destroy
  end

end
