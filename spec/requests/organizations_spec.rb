require 'spec_helper'

RSpec.describe "Organizations", type: :request do
  let(:admin) { FactoryBot.create :account, :admin }

  let(:organization) { FactoryBot.create :organization }

  let(:valid_attributes) { FactoryBot.attributes_for :organization }

  let(:invalid_attributes) { (FactoryBot.build :organization, :no_name).attributes.symbolize_keys }

  describe "GET /organizations" do
    let(:organizations) { FactoryBot.create_list(:organization, 10) }

    before(:each) do
      organizations
      get organizations_path,
        headers: auth_headers(admin.id)
    end

    it "should return list of existing organizations" do
      organization_response = json_response[:data]
      expect(organization_response.size).to eql organizations.size
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /organizations" do
    context "with valid params" do
      before(:each) do
        post organizations_path,
          headers: auth_headers(admin.id),
          params: { organization: valid_attributes}
      end

      it "should return the new organization in data attributes" do
        organization_response = json_response[:data][:attributes]
        expect(organization_response[:name]).to eql valid_attributes[:name]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do
      before(:each) do
        post organizations_path,
          headers: auth_headers(admin.id),
          params: { organization: invalid_attributes}
      end

      it "should return that the name can't be blank" do
        organization_response = json_response[:name]
        expect(organization_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "PUT /organizations/:organization_id" do
    let(:new_attributes) { FactoryBot.attributes_for :organization }

    context "with valid params" do
      before(:each) do
        put organization_path( organization.id ),
          headers: auth_headers( admin.id ),
          params: { organization: new_attributes }
      end

      it "should return the updated organization in data attributes" do
        organization_response = json_response[:data][:attributes]
        expect(organization_response[:name]).to eql new_attributes[:name]
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with invalid params" do
      before(:each) do
        put organization_path( organization.id ),
          headers: auth_headers( admin.id ),
          params: { organization: invalid_attributes }
      end

      it "should return that the name can't be blank" do
        organization_response = json_response[:name]
        expect(organization_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "DELETE /organizations/:organization_id" do
    before(:each) do
      delete organization_path( organization.id ),
        headers: auth_headers( admin.id )
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
