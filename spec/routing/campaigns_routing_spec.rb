require "spec_helper"

describe CampaignsController do
  describe "routing" do

    it "routes to #index" do
      get("/en/campaigns").should route_to("campaigns#index", :locale => "en")
    end

    it "routes to #new" do
      get("/en/campaigns/new").should route_to("campaigns#new", :locale => "en")
    end

    it "routes to #show" do
      get("/en/campaigns/1").should route_to("campaigns#show", :id => "1", :locale => "en")
    end

    it "routes to #edit" do
      get("/en/campaigns/1/edit").should route_to("campaigns#edit", :id => "1", :locale => "en")
    end

    it "routes to #create" do
      post("/en/campaigns").should route_to("campaigns#create", :locale => "en")
    end

    it "routes to #update" do
      put("/en/campaigns/1").should route_to("campaigns#update", :id => "1", :locale => "en")
    end

    it "routes to #destroy" do
      delete("/en/campaigns/1").should route_to("campaigns#destroy", :id => "1", :locale => "en")
    end
  end
end
