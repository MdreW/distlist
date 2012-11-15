require "spec_helper"

describe AttachmentsController do
  describe "routing" do
    it "routes to #show" do
      get("/en/campaigns/1/emails/1/attachments/1").should route_to("attachments#show", :campaign_id => "1", :email_id => "1", :id => "1", :locale => "en")
    end

    it "routes to #create" do
      post("/en/campaigns/1/emails/1/attachments").should route_to("attachments#create", :campaign_id => "1", :email_id => "1", :locale => "en")
    end

    it "routes to #destroy" do
      delete("/en/campaigns/1/emails/1/attachments/1").should route_to("attachments#destroy", :campaign_id => "1", :email_id => "1", :id => "1", :locale => "en")
    end

  end
end
