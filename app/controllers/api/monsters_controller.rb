class Api::MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :update, :destroy]

  # GET /monsters
  def index
    @monsters = Monster.all
    if params[:user_id]
      @monsters = @monsters.where(user_id: params[:user_id])
    end
    render json: @monsters
  end

  # GET /monsters/1
  def show
    render json: @monster
  end

  # POST /monsters
  def create
    @monster = Monster.new(monster_params)

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
