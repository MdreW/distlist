require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/users/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #create" do
      post("/users").should route_to("users#create")
    end

    it "routes to #destroy" do
      delete("/users/1").should route_to("users#destroy", :id => "1")
    end

    it "endis" do
      put("/users/1/endis").should route_to("users#endis", :id => "1")
    end

    it "swadmin" do
      put("/users/1/swadmin").should route_to("users#swadmin", :id => "1")
    end
  end
end
