require "spec_helper"

describe AddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/en/campaigns/1/addresses").should route_to("addresses#index", :campaign_id => "1", :locale => "en")
    end

    it "routes to #new" do
      get("/en/campaigns/1/addresses/new").should route_to("addresses#new", :campaign_id => "1", :locale => "en")
    end

    it "routes to #edit" do
      get("/en/campaigns/1/addresses/1/edit").should route_to("addresses#edit", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #create" do
      post("/en/campaigns/1/addresses").should route_to("addresses#create", :campaign_id => "1", :locale => "en")
    end

    it "routes to #update" do
      put("/en/campaigns/1/addresses/1").should route_to("addresses#update", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #destroy" do
      delete("/en/campaigns/1/addresses/1").should route_to("addresses#destroy", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to import" do
      get("/en/campaigns/1/addresses/import").should route_to("addresses#import", :campaign_id => "1", :locale => "en")
    end

    it "routes to csv" do
      post("/en/campaigns/1/addresses/csv").should route_to("addresses#csv", :campaign_id => "1", :locale => "en")
    end

    it "routes to export" do
      get("/en/campaigns/1/addresses/export").should route_to("addresses#export", :campaign_id => "1", :locale => "en")
    end

    it "unsubscribe" do
      get("/en/unsubscribe/1/1abcdef1111111111111111111111111111111111111111111").should route_to("addresses#unsubscribe", :campaign_id => "1", :pepper => "1abcdef1111111111111111111111111111111111111111111", :locale => "en")
    end

    it "unsubscribe_confirm" do
      post("/en/unsubscribe/1/1abcdef1111111111111111111111111111111111111111111/1").should route_to("addresses#unsubscribe_confirm", :campaign_id => "1", :pepper => "1abcdef1111111111111111111111111111111111111111111", :id => "1", :locale => "en")
    end
  end
end
