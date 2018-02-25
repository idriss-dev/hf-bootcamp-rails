require 'spec_helper'

describe "Accounts" do
  describe "GET #index" do
    let!(:accounts) { FactoryBot.create_list(:accounts, 10) }

    before { get :index }
    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it 'returns all accounts' do
      body = JSON.parse(reponse.body)
      expect(['data'].size).to eq(10)
    end

    it 'returns the requested account' do
        expect(json_response[:data][:attributes][:email]).to eq('kakashi@text.com')
    end
  end

  describe "GET #show" do
    before(:each) do
      @account = FactoryBot.create :account
      get :show, id: @account.id
    end

    it "should return the right user" do
      account_response = json_response[:account]
      expect(account_response[:email]).to eql @account.email
    end

    it { should respond_with 200 }
  end
end
