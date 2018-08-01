class Api::BodiesController < ApplicationController
  before_action :set_body, only: [:show, :update, :destroy]

  # GET /bodies
  def index
    @bodies = Body.all

    render json: @bodies
  end

  # GET /bodies/1
  def show
    render json: @body
  end

  # POST /bodies
  def create
    @body = Body.new(body_params)

    if @body.save
      render json: @body, status: :created, location: api_body_path(@body)
    else
      render json: @body.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bodies/1
  def update
    if @body.update(body_params)
      render json: @body
    else
      render json: @body.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bodies/1
  def destroy
    @body.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body
      @body = Body.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def body_params
      params.require(:body).permit(:type)
    end
end
