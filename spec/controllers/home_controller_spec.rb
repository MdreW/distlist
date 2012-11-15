require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "When user no logged" do
      get 'index',{locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "When user is logged" do
      user = create(:user)
      sign_in user
      get 'index', {locale: :en}
      response.should redirect_to(campaigns_path)
    end
  end

  describe "GET 'helpdesk'" do
    it "Get page" do
      get 'helpdesk', {locale: :en }
      response.should render_template("helpdesk")
    end
  end
end
