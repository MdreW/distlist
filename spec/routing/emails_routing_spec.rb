require "spec_helper"

describe EmailsController do
  describe "routing" do

    it "routes to #index" do
      get("/en/campaigns/1/emails").should route_to("emails#index", :campaign_id => "1", :locale => "en")
    end

    it "routes to #new" do
      get("/en/campaigns/1/emails/new").should route_to("emails#new", :campaign_id => "1", :locale => "en")
    end

    it "routes to #show" do
      get("/en/campaigns/1/emails/1").should route_to("emails#show", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #edit" do
      get("/en/campaigns/1/emails/1/edit").should route_to("emails#edit",:campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #create" do
      post("/en/campaigns/1/emails").should route_to("emails#create", :campaign_id => "1", :locale => "en")
    end

    it "routes to #update" do
      put("/en/campaigns/1/emails/1").should route_to("emails#update", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #destroy" do
      delete("/en/campaigns/1/emails/1").should route_to("emails#destroy", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "mail_me" do
      put("/en/campaigns/1/emails/1/mail_me").should route_to("emails#mail_me", :campaign_id => "1", :id => "1", :locale => "en")
    end

    it "log" do
      put("/en/campaigns/1/emails/1/getlog").should route_to("emails#getlog", :campaign_id => "1", :id => "1", :locale => "en")
    end
  end
end
