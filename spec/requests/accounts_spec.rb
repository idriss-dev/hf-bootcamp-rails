require 'spec_helper'

describe "Accounts", type: :request do
=begin
     n  describe "GET #index" do
     n    let!(:accounts) { FactoryBot.create_list(:account, 10) }
     n    let!(:current_user) { FactoryBot.create(:user) }
     n
     n    before { get accounts_path, headers: auth_headers(current_user) }
     n
     n    it "returns HTTP status 200" do
     n      expect(response).to have_http_status 200
     n    end
     n
     n    it 'returns all accounts' do
     n      body = JSON.parse(reponse.body)
     n      expect(['data'].size).to eq(10)
     n    end
     n
     n    it { should respond_with 200 }
     n  end
     n
     n  describe "GET #show" do
     n    before(:each) do
     n      @account = FactoryBot.create :account
     n      get :show, params: { id: @account.id }
     n    end
     n
     n    it "should return the right user" do
     n      account_response = json_response[:account]
     n      expect(account_response[:email]).to eql @account.email
     n    end
     n
     n    it { should respond_with 200 }
     n  end
=end
end
