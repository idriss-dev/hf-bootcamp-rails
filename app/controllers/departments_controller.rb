class DepartmentsController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]
  before_action :set_department, only: [:show, :update, :destroy]
  before_action :authenticate_account

=begin
       @api {get} /departments/ All
       @apiName allDepartments
       @apiGroup Department

       @apiHeader {String} Authorization='Bearer :jwt_token:'


       @apiSuccess (200) {Object} data list of existing departments

       @apiError (500) {Object} error Internal Server Error
=end
  def index
    @departments = Department.all
    render json: @departments
  end

  def show
    render json: @department
  end

=begin
       @api {post} /departments/ Add
       @apiName createDepartment
       @apiGroup Department

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the Department

       @apiSuccess (201) {Object} data new department

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  # POST /departments
  def create
    @department = Department.new(department_params)
    @department.account = current_account
    authorize @department

    if @department.save
      render json: @department, status: :created, location: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

=begin
       @api {put} /departments/:department_id Update
       @apiName updateDepartment
       @apiGroup Department

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the Department

       @apiSuccess (200) {Object} data updated department

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def update
    authorize @department
    if @department.update(department_params)
      render json: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

=begin
       @api {delete} /departments/:department_id delete
       @apiName deleteDepartment
       @apiGroup Department

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (204) Blank

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def destroy
    authorize @department
    @department.destroy
  end

  private
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params.require(:department).permit(:name, :organization_id)
    end
end
