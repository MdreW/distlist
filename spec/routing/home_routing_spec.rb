require "spec_helper"

describe HomeController do
  describe "routing" do
    it "routes to #index" do
      get("/").should route_to("home#index")
      get("/home").should route_to("home#index")
    end

    it "routes to #helpdesk" do
      get("/helpdesk").should route_to("home#helpdesk")
    end

    it "routes to #admin" do
      get("/admin").should route_to("home#admin")
    end
  end
end
