class ObjectivesController < ApplicationController
  before_action :authenticate_account
  before_action :set_objective, only: [:show, :update, :destroy]

  # GET /objectives
  def index
    @objectives = Objective.all

    render json: @objectives
  end

  # GET /objectives/1
  def show
    render json: @objective
  end

  # POST /objectives
  def create
    @objective = Objective.new(objective_params)

    if @objective.save
      render json: @objective, status: :created, location: @objective
    else
      render json: @objective.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /objectives/1
  def update
    if @objective.update(objective_params)
      render json: @objective
    else
      render json: @objective.errors, status: :unprocessable_entity
    end
  end

  # DELETE /objectives/1
  def destroy
    @objective.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def objective_params
      params.require(:objective).permit(:name, :description, :assignee_id, :due_date, :department_id, :status, :progress, :milestones, :priorities)
    end
end
