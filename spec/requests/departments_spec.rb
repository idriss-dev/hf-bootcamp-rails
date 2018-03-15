require 'spec_helper'

RSpec.describe "Departments", type: :request do

  let(:admin) { FactoryBot.create :account, :admin }

  let(:department) { FactoryBot.create :department }

  let(:departments) { FactoryBot.create_list(:department, 10) }

  let(:valid_new_department) { FactoryBot.attributes_for :department }

  let(:invalid_new_department) { { name: "" } }

  let(:valid_update_department) { FactoryBot.attributes_for :department }

  let(:invalid_update_department) { { name: "" } }

  let(:departments) { FactoryBot.create_list(:department, 10) }

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
          params: { department: valid_new_department}
      end

      it "should return the new department in data attributes" do
        department_response = json_response[:data][:attributes]
        expect(department_response[:name]).to eql valid_new_department[:name]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with invalid params" do
      before(:each) do
        post departments_path,
          headers: auth_headers(admin.id),
          params: { department: invalid_new_department}
      end

      it "should return that the name can't be blank" do
        department_response = json_response[:name]
        expect(department_response).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "PUT /departments/:department_id" do
    context "with valid params" do
      before(:each) do
        put department_path( department.id ),
          headers: auth_headers( admin.id ),
          params: { department: valid_update_department }
      end

      it "should return the updated department in data attributes" do
        department_response = json_response[:data][:attributes]
        expect(department_response[:name]).to eql valid_update_department[:name]
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with invalid params" do
      before(:each) do
        put department_path( department.id ),
          headers: auth_headers( admin.id ),
          params: { department: invalid_update_department }
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
      delete department_path( department.id ),
        headers: auth_headers( admin.id )
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
