require 'spec_helper'

describe "Objectives", type: :request do

  #TODO: write integration test to search by name
  #TODO: write integration test to search by description
  #TODO: write integration test to verify index returns the right number of elements

  #TODO: write integration test to create an objective with no parents
  #TODO: write integration test to create an objective with parents
  let(:valid_attributes) {
    FactoryBot.attributes_for :objective
  }

  let(:valid_attributes_child) {
    FactoryBot.attributes_for :objective, :child
  }

  let(:account) {
    FactoryBot.create :account
  }

  let(:department) {
    FactoryBot.create :department
  }

  let(:objectives) {
    FactoryBot.create_list(:objective, 10)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:objective).except(:name)
  }

  describe "GET /objectives" do
    context "with no search criteria specified" do
      before(:each) do
        get department_objectives_path(department.id, objectives[0].id),
          headers: auth_headers(account.id)
      end

      it "should return list of existing objectives" do
        objective_response = json_response[:data]
        expect(objective_response.size).to eql objectives.size
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with name criteria specified" do
      before(:each) do
        get department_objectives_path(department.id, objectives[0].id),
          params: {name: objectives[0].name},
          headers: auth_headers(account.id)
      end

      it "should return list of objectives related to the specified name" do
        objective_response = json_response[:data]
        expect(objective_response[0][:attributes][:name]).to eql objectives[0].name
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context "with description criteria specified" do
      before(:each) do
        get department_objectives_path(department.id, objectives[0].id),
          params: {description: objectives[0].description},
          headers: auth_headers(account.id)
      end

      it "should return list of objectives related to the specified description" do
        objective_response = json_response[:data]
        expect(objective_response[0][:attributes][:description]).to eql objectives[0].description
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe "POST objectives/:id/objectives" do
    context "with valid params" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(account.id),
          params: { objective: valid_attributes }
      end

      it "should return the objective" do
        objective_response = json_response[:data][:attributes]
        expect(objective_response[:name]).to eql valid_attributes[:name]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with child valid params" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(account.id),
          params: { objective: valid_attributes_child }
      end

      it "should return the objective" do
        objective_response = json_response[:data][:attributes]
        expect(objective_response[:name]).to eql valid_attributes_child[:name]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with unauth user" do
      before(:each) do
        post department_objectives_path(department.id),
          params: { objective: valid_attributes }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context "with missing attribute name" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(account.id),
          params: { objective: invalid_attributes }
      end

      it "renders the json errors on why the Objective could not be created, due to missing name" do
        expect(json_response[:name]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
