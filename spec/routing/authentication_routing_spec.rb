require 'spec_helper'

describe AuthenticationController, type: :routing do
  describe 'POST #auth' do
    it 'routes to POST auth to user_token#create' do
      expect(post :auth).to route_to('user_token#create')
    end
  end
end
