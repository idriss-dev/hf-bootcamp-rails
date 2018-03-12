class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :update, :destroy]

=begin
       @api {get} /organizations/ All
       @apiName allOrganization
       @apiGroup Organization

       @apiHeader {String} Authorization='Bearer :jwt_token:'


       @apiSuccess (200) {Object} data Query Results

       @apiError (422) {Object} Query Error
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

       @apiSuccess (201) {Object} data created Organization

       @apiError (422) {Object} Query Error
=end
  def create
    @organization = Organization.new(organization_params)
    @organization.account = current_account

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

       @apiError (422) {Object} Query Error
=end
  def update
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

       @apiSuccess (204)

       @apiError (422) {Object} Query Error
=end
  def destroy
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
