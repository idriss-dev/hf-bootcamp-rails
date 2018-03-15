require 'spec_helper'

RSpec.describe "Departments", type: :request do

  let(:account) {
    FactoryBot.create :account, :admin
  }

  let(:department) {
    FactoryBot.create :department
  }

  let(:departments) {
    FactoryBot.create_list(:department, 10)
  }

  let(:new_department) {
    FactoryBot.attributes_for :department
  }

  let(:update_department) {
    FactoryBot.attributes_for :department
  }

  describe "GET /departments" do
    before(:each) do
      get departments_path,
        headers: auth_headers(account.id)
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /departments" do
    before(:each) do
      post departments_path,
        headers: auth_headers(account.id),
        params: { department: new_department}
    end

    it "should return the new department" do
      department_response = json_response[:data][:attributes]
      expect(department_response[:name]).to eql new_department[:name]
    end

    it { expect(response).to have_http_status(:created) }
  end

  describe "PUT /departments/:department_id" do
    before(:each) do
      put department_path( department.id ),
        headers: auth_headers( account.id ),
        params: { department: update_department }
    end

    it "should return the updated department" do
      department_response = json_response[:data][:attributes]
      expect(department_response[:name]).to eql update_department[:name]
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe "DELETE /departments/:department_id" do
    before(:each) do
      delete department_path( department.id ),
        headers: auth_headers( account.id )
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
