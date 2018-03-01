class AccountsController < ApplicationController
  before_action :authenticate_account, :only => [:invite]
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

=begin
       @api {post} /accounts/signup Creates a company account
       @apiName SignAccount
       @apiGroup Account

       @apiParam {String} email Email of the user
       @apiParam {String} password Password of the user
       @apiParam {String} password_confirmation Password confirmation
       @apiParam {String} full_name Full name of the user

       @apiSuccess (200) {String} jwt the Json Web Token of the user
       @apiSuccess (200) {Object} User saved data

       @apiError (422) {Object} User Save Error
=end
  def signup
    new_admin = account_params
    new_admin[:is_admin] = true
    @account = Account.new(new_admin)

    token = Knock::AuthToken.new(payload: { sub: @account.id }).token

    if @account.save
      #binding.pry
    # TODO: this response should return only needed user data
      render json: { jwt: token, account: @account}, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

=begin
       @api {post} /accounts/invite invites a user
       @apiName InviteAccount
       @apiGroup Account

       @apiHeader {String} Authorization='Bearer :jwt-token:'

       @apiParam {String} email Email of the user

       @apiSuccess (200)  {Object} msg invitation sent

       @apiError (422) {Object} ModelAttr error message
       @apiError (401) {Object} User only admins can send invitations
=end

  def invite
    if current_account.is_admin
      new_account = invite_params
      new_account[:is_invited] = true
      @account = Account.new(new_account)

      if @account.save
        # NOTE: it would be better to have custom messages placed in a special folder
        render json: { msg: "invitation sent" }, status: :created, location: @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end
    else
        render json: { msg: "only admins can send invitations" }, status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  def invite_params
    params.require(:account).permit(:email)
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation, :is_admin, :full_name)
  end
end
