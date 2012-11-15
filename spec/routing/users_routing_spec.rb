require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/en/users").should route_to("users#index", :locale => "en")
    end

    it "routes to #new" do
      get("/en/users/new").should route_to("users#new", :locale => "en")
    end

    it "routes to #show" do
      get("/en/users/1").should route_to("users#show", :id => "1", :locale => "en")
    end

    it "routes to #create" do
      post("/en/users").should route_to("users#create", :locale => "en")
    end

    it "routes to #destroy" do
      delete("/en/users/1").should route_to("users#destroy", :id => "1", :locale => "en")
    end

    it "endis" do
      put("/en/users/1/endis").should route_to("users#endis", :id => "1", :locale => "en")
    end

    it "swadmin" do
      put("/en/users/1/swadmin").should route_to("users#swadmin", :id => "1", :locale => "en")
    end
  end
end
