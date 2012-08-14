require "spec_helper"

describe WeathersController do
  describe "routing" do

    it "routes to #index" do
      get("/weathers").should route_to("weathers#index")
    end

    it "routes to #new" do
      get("/weathers/new").should route_to("weathers#new")
    end

    it "routes to #show" do
      get("/weathers/1").should route_to("weathers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weathers/1/edit").should route_to("weathers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weathers").should route_to("weathers#create")
    end

    it "routes to #update" do
      put("/weathers/1").should route_to("weathers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weathers/1").should route_to("weathers#destroy", :id => "1")
    end

  end
end
