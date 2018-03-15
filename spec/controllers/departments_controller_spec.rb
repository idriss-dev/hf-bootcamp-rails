require 'spec_helper'

RSpec.describe DepartmentsController, type: :controller do

  before(:each) do
    valid_attributes[:account_id] = admin_account.id
  end

  let(:valid_attributes) {
    FactoryBot.attributes_for :department
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
      department = Department.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      request.headers.merge!(auth_headers(admin_account.id))
      department = Department.create! valid_attributes
      get :show, params: {id: department.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Department" do
        request.headers.merge!(auth_headers(admin_account.id))
        expect {
          post :create, params: {department: valid_attributes}
        }.to change(Department, :count).by(1)
      end

      it "renders a JSON response with the new department" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {department: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(department_url(Department.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new department" do
        request.headers.merge!(auth_headers(admin_account.id))
        post :create, params: {department: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for :department
      }

      it "updates the requested department" do
        request.headers.merge!(auth_headers(admin_account.id))
        allow(controller).to receive(:current_account) { admin_account }
        department = Department.create! valid_attributes
        put :update, params: {id: department.to_param, department: new_attributes}
        department.reload
        expect(response).to be_success
        expect(department.name).to eql new_attributes[:name]
      end

      it "renders a JSON response with the department" do
        request.headers.merge!(auth_headers(admin_account.id))
        department = Department.create! valid_attributes

        put :update, params: {id: department.to_param, department: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the department" do
        request.headers.merge!(auth_headers(admin_account.id))
        department = Department.create! valid_attributes

        put :update, params: {id: department.to_param, department: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested department" do
      request.headers.merge!(auth_headers(admin_account.id))
      department = Department.create! valid_attributes
      expect {
        delete :destroy, params: {id: department.to_param}
      }.to change(Department, :count).by(-1)
    end
  end
end
