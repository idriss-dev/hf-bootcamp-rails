require 'spec_helper'

RSpec.describe "Departments", type: :request do

  let(:admin) { FactoryBot.create :account, :admin }

  let(:valid_attributes) { (FactoryBot.build :department).attributes.symbolize_keys  }

  let(:invalid_attributes) { (FactoryBot.build :department, :no_name).attributes.symbolize_keys }

  let(:departments) { FactoryBot.create_list(:department, 10) }

  describe "GET /departments/:department_id" do

    before(:each) do
      get department_path(departments[0].id),
        headers: auth_headers(admin.id)
    end

    it "should return specified department" do
      department_response = json_response[:data]
      expect(Integer(department_response[:id])).to eql departments[0].id
      expect(department_response[:attributes][:name]).to eql departments[0].name
      expect(department_response[:attributes]["organization-id".to_sym]).to eql departments[0].organization_id
      expect(department_response[:attributes]["account-id".to_sym]).to eql departments[0].account_id
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /departments" do

    before(:each) do
      departments
      get departments_path,
        headers: auth_headers(admin.id)
    end

    it "should return list of existing departments" do
      department_response = json_response[:data]
      expect(department_response.size).to eql departments.size
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /departments" do
    context "with valid params" do
      before(:each) do
        post departments_path,
          headers: auth_headers(admin.id),
          params: { department: valid_attributes}
      end

      it "should return the new department in data attributes" do
        department_response = json_response[:data][:attributes]
        expect(department_response[:name]).to eql valid_attributes[:name]
        expect(department_response["organization-id"]).to eql valid_attributes["organization-id"]
        expect(department_response["account-id"]).to eql valid_attributes["account-id"]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do
      before(:each) do
        post departments_path,
          headers: auth_headers(admin.id),
          params: { department: invalid_attributes}
      end

      it "should return that the name can't be blank" do
        department_response = json_response[:name]
        expect(department_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "PUT /departments/:department_id" do

    let(:new_attributes) { FactoryBot.attributes_for :department }

    context "with valid params" do
      before(:each) do
        put department_path( departments[0].id ),
          headers: auth_headers( admin.id ),
          params: { department: new_attributes }
      end

      it "should return the updated department in data attributes" do
        department_response = json_response[:data][:attributes]
        expect(department_response[:name]).to eql new_attributes[:name]
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with invalid params" do
      before(:each) do
        put department_path( departments[0].id ),
          headers: auth_headers( admin.id ),
          params: { department: invalid_attributes }
      end

      it "should return that the name can't be blank" do
        department_response = json_response[:name]
        expect(department_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "DELETE /departments/:department_id" do
    before(:each) do
      delete department_path( departments[0].id ),
        headers: auth_headers( admin.id )
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
