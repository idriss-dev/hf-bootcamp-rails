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

  let(:valid_invited_user) {
    { email: FFaker::Internet.email }
  }

  let(:invalid_invited_user) {
    { email: FFaker::Name.name }
  }

  let(:admin_account) {
    FactoryBot.create :account
  }

  let(:user_account) {
    FactoryBot.create :account, :not_admin
  }

  describe "POST #signin" do
    context "with valid params" do
      before(:each) do
        post user_signin_path(accounts_path),
             params: { account: admin_account }
      end

      it "should return the JWT token" do
        expect(json_response[:meta][:jwt]).not_to eql :nil
      end

      # NOTE it should be better to refactor sensitive data validation section
      it "should return the account" do
        account_response = json_response[:data][:attributes]
        expect(account_response[:email]).to eql valid_attributes[:email]
      end

      it "should not have password in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password)
      end

      it "should not have password_confirmation in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password_confirmation)
      end

      it "should not have password_digest in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password_digest)
      end

      it "should not have is_admin in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:is_admin)
      end

      it "should not have is_invited in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:is_invited)
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with invalid params" do
      before(:each) do
        post user_signup_path(accounts_path),
             params: { account: invalid_attributes }
      end

      it "renders the json errors on why the Account could not be created" do
        expect(json_response[:email]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "POST #signup" do
    context "with valid params" do
      before(:each) do
        post user_signup_path(accounts_path),
             params: { account: valid_attributes }
      end

      it "should return the JWT token" do
        expect(json_response[:meta][:jwt]).not_to eql :nil
      end

      it "should return the account" do
        account_response = json_response[:data][:attributes]
        expect(account_response[:email]).to eql valid_attributes[:email]
      end

      it "should not have password in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password)
      end

      it "should not have password_confirmation in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password_confirmation)
      end

      it "should not have password_digest in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:password_digest)
      end

      it "should not have is_admin in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:is_admin)
      end

      it "should not have is_invited in the account response" do
        account_response = json_response[:data][:attributes]
        expect(account_response).to_not include(:is_invited)
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do
      before(:each) do
        post user_signup_path(accounts_path),
             params: { account: invalid_attributes }
      end

      it "renders the json errors on why the Account could not be created" do
        expect(json_response[:email]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "POST #invite" do
    context "with valid params" do
      before(:each) do
        post user_invite_path(accounts_path),
             headers: auth_headers(admin_account.id),
             params: { account: valid_invited_user }
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do

      before(:each) do
        post user_invite_path(accounts_path),
             headers: auth_headers(admin_account.id),
             params: { account: invalid_invited_user }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context "with unauthenticated user" do

      before(:each) do
        post user_invite_path(accounts_path),
             params: { account: invalid_invited_user }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context "with non admin user" do

      before(:each) do
        post user_invite_path(accounts_path),
             headers: auth_headers(user_account.id),
             params: { account: valid_invited_user }
      end

      it "renders the json errors on why the Invitation could not be created" do
        expect(json_response[:data][:msg]).to include "only admins can send invitations"
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
