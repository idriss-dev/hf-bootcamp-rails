class ApplicationController < ActionController::API

=begin
       @api {post} /signin signin a user
       @apiName SigninAccount
       @apiGroup Account

       @apiParam {Object} auth Authentication information (email, password)

       @apiParamExample {json} Request-Example:
       {
        "auth": {
          "email": "email@example.com",
          "password": "NotASekeret"
        }
       }

       @apiSuccess (200)  {String} success message

       @apiError (422) {Object} User Save Error
=end


  include Knock::Authenticable
end
