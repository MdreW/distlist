require "spec_helper"

describe HomeController do
  describe "routing" do
    it "routes to root no locale" do
      get("/").should route_to("home#index", :locale => :en)
    end

    it "routes to root with locale" do
      get("/en").should route_to("home#index", :locale => "en")
    end

    it "routes to #helpdesk" do
      get("/en/helpdesk").should route_to("home#helpdesk", :locale => "en")
    end

    it "routes to #admin" do
      get("/en/admin").should route_to("home#admin", :locale => "en")
    end
  end
end
