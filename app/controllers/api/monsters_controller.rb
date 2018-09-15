class Api::MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]

  # GET /monsters
  def index
    @monsters = Monster.all.includes(:user, :liked_by)

    case params[:sort_by]
      when 'newest'
        @monsters = @monsters.unscoped.order(created_at: :desc).limit(params[:limit]).offset(params[:offset])
        @monsters = sort_since(@monsters, params[:since]) if params[:since]
        @monsters = sort_username(@monsters, params[:username]) if params[:username]
      when 'oldest'
        @monsters = Monster.unscoped.order(created_at: :asc).limit(params[:limit]).offset(params[:offset])
        @monsters = Monster.sort_since(@monsters, params[:since]) if params[:since]
        @monsters = Monster.sort_username(@monsters, params[:username]) if params[:username]
    end

    if !params[:sort_by]
      render json: 'Missing params', status: :bad_request
    else
      render json: Monster.monsters_with_associations(@monsters)
    end
  end

  # GET /monsters/1
  def show
    render json: Monster.monster_with_associations(@monster)
  end

  # POST /monsters
  def create
    @monster = current_user.monsters.build(monster_params)

    if @monster.save
      render json: @monster, status: :created, location: api_monster_path(@monster)
    else
      render json: @monster.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /monsters/1
  def update
    if @monster.update(monster_params)
      render json: @monster
    else
      render json: @monster.errors, status: :unprocessable_entity
    end
  end

  # DELETE /monsters/1
  def destroy
    @monster.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster = Monster.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def monster_params
      params.require(:monster).permit(
        :name, :user_id,
        :body_type, :body_fill,
        :face_type, :face_fill,
        :headwear_type, :headwear_fill,
        :eyes_type, :eyes_fill,
        :mouth_type, :mouth_fill,
        :right_arm_type, :right_arm_fill,
        :left_arm_type, :left_arm_fill,
        :legs_type, :legs_fill
      )
    end
end
