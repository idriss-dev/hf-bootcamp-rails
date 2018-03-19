class OrganizationsController < ApplicationController
  after_action :verify_authorized, except: [:tree, :index, :show]
  before_action :set_organization, only: [:tree, :show, :update, :destroy]
  before_action :authenticate_account

=begin
       @api {get} /organizations/ All
       @apiName allOrganization
       @apiGroup Organization

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (200) {Object} data list of existing organizations

       @apiError (500) {Object} error Internal Server Error
=end
  def index
    @organizations = Organization.all
    render json: @organizations
  end

  # GET /organizations/1
  def show
    render json: @organization
  end

=begin
       @api {post} /organizations/ Add
       @apiName createOrganization
       @apiGroup Organization

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the Organization

       @apiSuccess (201) {Object} data new Organization

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def create
    @organization = Organization.new(organization_params)
    @organization.account = current_account
    authorize @organization

    if @organization.save
      render json: @organization, status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

=begin
       @api {put} /organizations/:organization_id Update
       @apiName updateOrganization
       @apiGroup Organization

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiParam {String} name name of the Organization

       @apiSuccess (200) {Object} data updated organization

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def update
    authorize @organization
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

=begin
       @api {delete} /organization/:organization_id delete
       @apiName deleteOrganization
       @apiGroup Organization

       @apiHeader {String} Authorization='Bearer :jwt_token:'

       @apiSuccess (204) Blank

       @apiError (422) {Object} attribute Unprocessable Entity
=end
  def destroy
    authorize @organization
    @organization.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name)
    end
end
