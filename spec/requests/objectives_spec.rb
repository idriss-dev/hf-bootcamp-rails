require 'spec_helper'

describe "Objectives", type: :request do

  let(:valid_objective) {
    FactoryBot.attributes_for :objective
  }

  let(:user_account) {
    FactoryBot.create :account, :not_admin
  }

  let(:department) {
    FactoryBot.create :department
  }

  let(:objectives) {
    FactoryBot.create_list(:objective, 10)
  }

  let(:objective_missing_name) {
    FactoryBot.attributes_for :objective, :missing_name
  }

  let(:objective_missing_account) {
    FactoryBot.attributes_for :objective, :missing_account
  }

  let(:objective_missing_department) {
    FactoryBot.attributes_for :objective, :missing_department
  }

  describe "GET /objectives" do
    before(:each) do
      get department_objective_path(department.id, objectives[0].id),
        headers: auth_headers(user_account.id)
    end

    it "works! (now write some real specs)" do
      get department_objective_path(department.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST departments/:id/objectives" do
    context "with valid params" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(user_account.id),
          params: { objective: valid_objective }
      end

      it "should return the objective" do
        objective_response = json_response[:data][:attributes]
        expect(objective_response[:name]).to eql valid_objective[:name]
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "with unauth user" do
      before(:each) do
        post department_objectives_path(department.id),
          params: { objective: valid_objective }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context "with missing attribute name" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(user_account.id),
          params: { objective: objective_missing_name }
      end

      it "renders the json errors on why the Objective could not be created, due to missing name" do
        expect(json_response[:name]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context "with missing department id" do
      before(:each) do
        post department_objectives_path(department.id),
          headers: auth_headers(user_account.id),
          params: { objective: objective_missing_department }
      end

      it "renders the json errors on why the Objective could not be created, due to missing department" do
        expect(json_response[:department]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
