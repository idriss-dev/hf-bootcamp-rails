require 'spec_helper'

RSpec.describe OrganizationsController, type: :controller do
# TODO removes this line and replace with the right build valid_attributes
  before(:each) do
    valid_attributes[:account_id] = admin_account.id
  end

  let(:valid_attributes) {
    (FactoryBot.build :organization).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    (FactoryBot.build :organization, :no_name).attributes.symbolize_keys
  }

  let(:admin_account) {
    FactoryBot.create :account, :admin
  }


  describe "GET #index" do
    it "returns a success response" do
      request.headers.merge!(auth_headers(admin_account.id))
      organization = Organization.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      request.headers.merge!(auth_headers(admin_account.id))
      organization = Organization.create! valid_attributes
      get :show, params: {id: organization.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        expect {
          post :create, params: {organization: valid_attributes}
        }.to change(Organization, :count).by(1)
      end

      it "renders a JSON response with the new organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {organization: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(organization_url(Organization.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {organization: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for :organization
      }

      it "updates the requested organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        allow(controller).to receive(:current_account) { admin_account }
        organization = Organization.create! valid_attributes
        put :update, params: {id: organization.to_param, organization: new_attributes}
        organization.reload
        expect(response).to be_success
        expect(organization.name).to eql new_attributes[:name]
      end

      it "renders a JSON response with the organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        organization = Organization.create! valid_attributes

        put :update, params: {id: organization.to_param, organization: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the organization" do
        request.headers.merge!(auth_headers(admin_account.id))
        organization = Organization.create! valid_attributes

        put :update, params: {id: organization.to_param, organization: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested organization" do
      request.headers.merge!(auth_headers(admin_account.id))
      organization = Organization.create! valid_attributes
      expect {
        delete :destroy, params: {id: organization.to_param}
      }.to change(Organization, :count).by(-1)
    end
  end
end
