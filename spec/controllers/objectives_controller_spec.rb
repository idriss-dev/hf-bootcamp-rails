require 'spec_helper'

RSpec.describe ObjectivesController, type: :controller do

  before(:each) do
    valid_attributes[:account_id] = admin_account.id
  end

  let(:valid_attributes) {
    FactoryBot.attributes_for :objective
  }

  let(:invalid_attributes) {
    { name: "" }
  }

  let(:admin_account) {
    FactoryBot.create :account, :admin
  }


  describe "GET #index" do
    it "returns a success response" do
      request.headers.merge!(auth_headers(admin_account.id))
      objective = objective.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      request.headers.merge!(auth_headers(admin_account.id))
      objective = objective.create! valid_attributes
      get :show, params: {id: objective.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        expect {
          post :create, params: {objective: valid_attributes}
        }.to change(objective, :count).by(1)
      end

      it "renders a JSON response with the new objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {objective: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(objective_url(objective.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {objective: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for :objective
      }

      it "updates the requested objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        allow(controller).to receive(:current_account) { admin_account }
        objective = objective.create! valid_attributes
        put :update, params: {id: objective.to_param, objective: new_attributes}
        objective.reload
        expect(response).to be_success
        expect(objective.name).to eql new_attributes[:name]
      end

      it "renders a JSON response with the objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        objective = objective.create! valid_attributes

        put :update, params: {id: objective.to_param, objective: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the objective" do
        request.headers.merge!(auth_headers(admin_account.id))
        objective = objective.create! valid_attributes

        put :update, params: {id: objective.to_param, objective: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested objective" do
      request.headers.merge!(auth_headers(admin_account.id))
      objective = objective.create! valid_attributes
      expect {
        delete :destroy, params: {id: objective.to_param}
      }.to change(objective, :count).by(-1)
    end
  end

end
