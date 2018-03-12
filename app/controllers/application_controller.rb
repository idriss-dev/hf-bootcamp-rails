class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include Pundit
  protect_from_forgery

  include Knock::Authenticable

  ActiveModelSerializers.config.adapter = :json_api

  def pundit_user
      current_account
  end
end
