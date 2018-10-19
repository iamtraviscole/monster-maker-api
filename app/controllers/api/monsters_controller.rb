class Api::MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]

  # GET /monsters
  def index
    case params[:sort_by]
      when 'newest'
        @monsters = Monster.order(created_at: :desc).limit(params[:limit])
          .offset(params[:offset]).includes(:user, :liked_by, :tags)
        @monsters = sort_monsters(@monsters, params)
      when 'oldest'
        @monsters = Monster.order(created_at: :asc).limit(params[:limit])
          .offset(params[:offset]).includes(:user, :liked_by, :tags)
        @monsters = sort_monsters(@monsters, params)
      when 'popular'
        @monsters = Monster.left_joins(:likes).group(:id)
          .order('COUNT(monsters.id) DESC').limit(params[:limit])
          .offset(params[:offset]).includes(:user, :liked_by, :tags)
        @monsters = sort_monsters(@monsters, params)
    end

    if !params[:sort_by]
      render json: 'Missing params', status: :bad_request
    else
      render json: Monster.monsters_with_associations(@monsters)
    end
  end

  # GET /monsters/1
  def show
    if @monster
      render json: Monster.monster_with_associations(@monster)
    else
      render status: :not_found
    end
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
    monst_params = monster_params.clone
    monst_params.delete(:tags_attributes) if !tags_changed?(monst_params, @monster)

    if @monster.update(monst_params)
      render json: Monster.monster_with_associations(@monster)
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
        :legs_type, :legs_fill,
        tags_attributes: [names: []]
      )
    end

    def tag_params
      params.require(:tags).permit(names: [])
    end

    def sort_monsters(monsters, params)
      sorted_monsters = monsters
      if params[:since]
        sorted_monsters.where('created_at < ?', Time.at(params[:since]))
      end
      if params[:username]
        sorted_monsters.where(user: User.where(username: params[:username]))
      end
      if params[:search]
        search_term = '%' + params[:search].strip + '%'
        sorted_monsters = monsters.left_joins(:user, :tags)
          .where('users.username LIKE ? OR monsters.name LIKE ? OR tags.name LIKE ?',
          search_term, search_term, search_term).distinct
      end
      sorted_monsters
    end

    def tags_changed?(params, monster)
      param_tags = params[:tags_attributes][:names]
      monster_tags = monster.tags.map {|tag| tag.name}
      if param_tags.length != monster_tags.length
        return true
      elsif
        param_tags.each_with_index do |param_tag, i|
         if param_tags[i] != monster_tags[i]
           return true
         end
        end
      end
      false
    end

end
