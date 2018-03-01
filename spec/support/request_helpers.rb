module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module AuthHelpers
    def auth_headers(account_id)
      token = Knock::AuthToken.new(payload: { sub: account_id }).token
      {
        'Authorization': "Bearer #{token}"
      }
    end
  end

  module AccountHelpers
    def user_invite_path(accounts_path)
      accounts_path + '/invite'
    end

    def user_signup_path(accounts_path)
      accounts_path + '/signup'
    end
  end
end
