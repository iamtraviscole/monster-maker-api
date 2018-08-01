class Api::UnlockedBodiesController < ApplicationController
  before_action :set_unlocked_body, only: [:show, :update, :destroy]

  # GET /unlocked_bodies
  def index
    @unlocked_bodies = UnlockedBody.all

    render json: @unlocked_bodies
  end

  # GET /unlocked_bodies/1
  def show
    render json: @unlocked_body
  end

  # POST /unlocked_bodies
  def create
    @unlocked_body = UnlockedBody.new(unlocked_body_params)

    if @unlocked_body.save
      render json: @unlocked_body, status: :created, location: unlocked_bodies_path(@unlocked_body)
    else
      render json: @unlocked_body.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /unlocked_bodies/1
  def update
    if @unlocked_body.update(unlocked_body_params)
      render json: @unlocked_body
    else
      render json: @unlocked_body.errors, status: :unprocessable_entity
    end
  end

  # DELETE /unlocked_bodies/1
  def destroy
    @unlocked_body.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unlocked_body
      @unlocked_body = UnlockedBody.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def unlocked_body_params
      params.fetch(:unlocked_body, {})
    end
end
