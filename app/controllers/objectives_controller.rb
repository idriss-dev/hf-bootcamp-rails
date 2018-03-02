class ObjectivesController < ApplicationController
  before_action :authenticate_account
  before_action :set_objective, only: [:show, :update, :destroy]
  before_action :set_department, only: [:create]

  # GET /objectives
  def index
    @objectives = Objective.all
    render json: @objectives
  end

  # GET /objectives/1
  def show
    render json: @objective
  end

=begin
       @api {post} /departments/:department_id/objectives Creates an objective
       @apiName createObjective
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the objective
       @apiParam {String} description description of the objective
       @apiParam {String} due_date Due date for the objective to be delivered
       @apiParam {Number} status {2: Green, 1: Orange, 0: Red}
       @apiParam {String} progress percentage progress on the project

       @apiSuccess (200) {Object} Objective created objective

       @apiError (422) {Object} Objective Save Error
=end

  def create
    @objective = Objective.new(objective_params)
    @objective.account = current_account
    @objective.department = @department

    if @objective.save
      render json: @objective, status: :created
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

    def set_department
      @department = Department.find(params[:department_id])
    end

    # Only allow a trusted parameter "white list" through.
    def objective_params
      params.require(:objective).permit(:name, :description, :assignee_id, :due_date, :department_id, :status, :progress, :milestones, :priorities)
    end
end
