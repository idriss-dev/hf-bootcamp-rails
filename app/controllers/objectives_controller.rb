class ObjectivesController < ApplicationController
  before_action :authenticate_account
  before_action :set_objective, only: [:show, :update, :destroy]
  before_action :set_department, only: [:create]

# TODO update APIDOCS with the correct apiError and apiSuccess information
=begin
       @api {get} /departments/:department_id/objectives?name=[value]&description=[value] search objectives by title, description
       @apiName  allObjectives
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (200) {Object} Objectives results

       @apiError (422) {Object} Objective Query Error
=end
  # GET /objectives
  def index
    @objectives = Objective.where(objective_search_params)
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
       @apiParam {Number} status {2: green, 1: orange, 0: red}
       @apiParam {String} progress percentage progress on the project

       @apiSuccess (201) {Object} Objective created objective

       @apiError (422) {Object} Objective Save Error
=end

  def create
    @objective = Objective.new(objective_params)
    @objective.account = current_account
    @objective.department = @department
    @objective.parent = Objective.find_by_id(params.require(:objective)[:parent_id])

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
    binding.pry
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
      params.require(:objective).permit(:name, :description, :due_date, :department_id, :status, :progress, :priorities, :milestones => [], :json_milestones => {})
    end

    def objective_search_params
      params.permit(:name, :description)
    end
end
