class ObjectivesController < ApplicationController
  before_action :authenticate_account
  before_action :set_objective, only: [:show, :update, :destroy]
  before_action :set_objective_tree, only: [:tree]
  before_action :set_department, only: [:create]

=begin
       @api {get} /departments/:department_id/objectives?name=[value]&description=[value] search objectives by title, description
       @apiName  allObjectives
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (200) {Object} data list of existing objectives

       @apiError (500) {Object} error Internal Server Error
=end
  # GET /objectives
  def index
    @objectives = Objective.where(objective_search_params)
    render json: @objectives
  end

=begin
       @api {get} /departments/:department_id/objectives/:id/tree render of tree of objective from an objective parent id
       @apiName  treeObjectives
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (200) {Object} data tree of objectives

       @apiError (500) {Object} error Internal Server Error
=end
  def tree
    render json: @objective_tree
  end

  # GET /objectives/1
  def show
    render json: @objective
  end

=begin
       @api {post} /departments/:department_id/objectives Creates
       @apiName createObjective
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the objective
       @apiParam {String} description description of the objective
       @apiParam {String} due_date Due date for the objective to be delivered
       @apiParam {Number} status {2: green, 1: orange, 0: red}
       @apiParam {String} progress percentage progress on the project
       @apiParam {Array} milestones array of string of milestones name
       @apiParam {Number} status {4: p5, 3: p4, 2: p3, 1: p2, 0: p1 }

       @apiSuccess (201) {Object} Objective created objective

       @apiError (422) {Object} attribute Unprocessable Entity
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

=begin
       @api {put} /departments/:department_id/objectives/:objective_id Update
       @apiName updateObjective
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the objective
       @apiParam {String} description description of the objective
       @apiParam {String} due_date Due date for the objective to be delivered
       @apiParam {Number} status {2: green, 1: orange, 0: red}
       @apiParam {String} progress percentage progress on the project
       @apiParam {Array} milestones array of string of milestones name
       @apiParam {Number} status {4: p5, 3: p4, 2: p3, 1: p2, 0: p1 }

       @apiSuccess (200) {Object} Objective created objective

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def update
    if @objective.update(objective_params)
      render json: @objective
    else
      render json: @objective.errors, status: :unprocessable_entity
    end
  end

=begin
       @api {delete} /departments/:department_id/objectives/:objective_id delete
       @apiName deleteObjective
       @apiGroup Objective

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (204) Blank

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def destroy
    @objective.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
    end

    def set_objective_tree
      @objective_tree = Objective.find(params[:id]).subtree.arrange_serializable
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
