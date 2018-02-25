require 'spec_helper'

describe "Accounts" do
  describe "GET /accounts" do
    let!(:accounts) { FactoryBot.create_list(:accounts, 10) }

    before { get :index }
    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it 'returns all accounts' do
      body = JSON.parse(reponse.body)
      expect(body['data'].size).to eq(10)
    end
  end
end
