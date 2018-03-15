require "spec_helper"

RSpec.describe ObjectivesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "departments/1/objectives").to route_to("objectives#index", :department_id => "1")
    end


    it "routes to #show" do
      expect(:get => "departments/1/objectives/1").to route_to("objectives#show", :id => "1", :department_id => "1")
    end


    it "routes to #create" do
      expect(:post => "departments/1/objectives").to route_to("objectives#create", :department_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "departments/1/objectives/1").to route_to("objectives#update", :id => "1", :department_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "departments/1/objectives/1").to route_to("objectives#update", :id => "1", :department_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "departments/1/objectives/1").to route_to("objectives#destroy", :id => "1", :department_id => "1")
    end

  end
end
