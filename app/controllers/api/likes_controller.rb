class Api::LikesController < ApplicationController
  before_action :authenticate_user

  def like
    user = current_user
    monster = Monster.find(params[:monster_id])
    user_like = user.likes.build(monster_id: monster.id)

    if user_like.save
      monster_with_associations = Monster.monster_with_associations(monster)
      render json: monster_with_associations
    end
  end

  def unlike
    user = current_user
    puts 'CURRENT USER', user.username
    like = user.likes.find_by(monster_id: params[:monster_id])

    if like.destroy
      monster = Monster.find(params[:monster_id])
      monster_with_associations = Monster.monster_with_associations(monster)
      render json: monster_with_associations
    end
  end

end
