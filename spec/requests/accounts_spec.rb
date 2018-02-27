require 'spec_helper'

describe "Accounts", type: :request do
  let(:valid_attributes) {
    FactoryBot.attributes_for :account
  }

  let(:invalid_attributes) {
    {
      password: "12345678",
      password_confirmation: "12345678"
    }
  }

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        post accounts_path, params: { account: valid_attributes }
      end

      it "should return the JWT token" do
        expect(json_response[:jwt]).not_to eql :nil
      end

      it "should return the account" do
        account_response = json_response[:account]
        expect(account_response[:email]).to eql valid_attributes[:email]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do
      before(:each) do
        post accounts_path, params: { account: invalid_attributes }
      end

      it "renders the json errors on why the Account could not be created" do
        expect(json_response[:email]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
