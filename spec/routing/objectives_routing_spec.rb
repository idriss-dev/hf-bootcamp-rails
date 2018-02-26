require "spec_helper"

RSpec.describe ObjectivesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/objectives").to route_to("objectives#index")
    end


    it "routes to #show" do
      expect(:get => "/objectives/1").to route_to("objectives#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/objectives").to route_to("objectives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/objectives/1").to route_to("objectives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/objectives/1").to route_to("objectives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/objectives/1").to route_to("objectives#destroy", :id => "1")
    end

  end
end
