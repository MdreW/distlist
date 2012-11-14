require 'spec_helper'

describe HomeController do

  before(:each) do
    @user = create(:user)
    @admin = create(:admin)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET 'index'" do
    it "When user no logged" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
    it "When user is logged" do
      user = create(:user)
      sign_in user
      get 'index'
      response.should redirect_to(campaigns_path)
    end
  end

  describe "GET 'helpdesk'" do
    it "Get page" do
      get 'helpdesk'
      response.should render_template("helpdesk")
    end
  end
end
