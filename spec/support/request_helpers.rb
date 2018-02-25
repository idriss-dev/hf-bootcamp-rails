module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module AuthHelpers
    def auth_headers(user)
      token = Knock::AuthToken.new(payload: { sub: user.id }).token
      {
        'Authorization': "Bearer #{token}"
      }
    end
  end
end
