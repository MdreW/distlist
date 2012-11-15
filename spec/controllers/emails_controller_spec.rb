require 'spec_helper'

describe EmailsController do
  describe "GET index" do
    it "@emails" do
      email = create(:email)
      sign_in email.campaign.user
      get :index, {campaign_id: email.campaign.to_param, locale: :en}
      assigns(:emails).should eq([email])
    end
    it "no login" do
      email = create(:email)
      get :index, {campaign_id: email.campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      email = create(:email)
      email2 = create(:email)
      sign_in email2.campaign.user
      get :index, {campaign_id: email.campaign.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "GET show" do
    it "@email" do
      email = create(:email)
      sign_in email.campaign.user
      get :show, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      assigns(:email).should eq(email)
    end
    it "no login" do
      email = create(:email)
      get :show, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      email = create(:email)
      email2 = create(:email)
      sign_in email2.campaign.user
      get :show, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "GET new" do
    it "new email as @email" do
      campaign = create(:campaign)
      sign_in campaign.user
      get :new, {campaign_id: campaign.to_param, locale: :en}
      assigns(:email).should be_a_new(Email)
    end
    it "no login" do
      campaign = create(:campaign)
      get :new, {campaign_id: campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      campaign = create(:campaign)
      campaign2 = create(:campaign)
      sign_in campaign2.user
      get :new, {campaign_id: campaign.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "GET edit" do
    it "@email" do
      email = create(:email)
      sign_in email.campaign.user
      get :edit, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      assigns(:email).should eq(email)
    end
    it "no login" do
      email = create(:email)
      get :edit, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      email = create(:email)
      email2 = create(:email)
      sign_in email2.campaign.user
      get :edit, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "POST create" do
    describe "valid" do
      it "param" do
        campaign = create(:campaign)
        sign_in campaign.user
        expect {
          post :create, {campaign_id: campaign.to_param, email: attributes_for(:email, :id => campaign.to_param), locale: :en}
        }.to change(Email, :count).by(1)
      end
      it "assigns a newly created email as @email" do
        campaign = create(:campaign)
        sign_in campaign.user
        post :create, {campaign_id: campaign.to_param, email: attributes_for(:email), locale: :en}
        assigns(:email).should be_a(Email)
        assigns(:email).should be_persisted
      end
      it "redirects to the created email" do
        campaign = create(:campaign)
        sign_in campaign.user
        post :create, {campaign_id: campaign.to_param, email: attributes_for(:email), locale: :en}
        response.should redirect_to(campaign_email_path(campaign.to_param, Email.last))
      end
    end

    describe "invalid" do
      it "param" do
        campaign = create(:campaign)
        sign_in campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Email.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: campaign.to_param, email: {}, locale: :en}
        assigns(:email).should be_a_new(Email)
      end
      it "re-renders 'new'" do
        campaign = create(:campaign)
        sign_in campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Email.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: campaign.to_param, email: {}, locale: :en}
        response.should render_template("new")
      end
      it "no autorized" do
        campaign = create(:campaign)
        campaign2 = create(:campaign)
        sign_in campaign2.user
        post :create, {campaign_id: campaign.to_param, email: attributes_for(:email), locale: :en}
        response.response_code.should == 401
      end
      it "no login" do
        campaign = create(:campaign)
        post :create, {campaign_id: campaign.to_param, email: attributes_for(:email), locale: :en}
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT update" do
    describe "valid" do
      it "param" do
        email = create(:email)
        sign_in email.campaign.user
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {subject: "Updated"}, locale: :en}
        assigns(:email).subject.should eql "Updated"
      end
      it "redirect" do
        email = create(:email)
        sign_in email.campaign.user
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {subject: "Updated"}, locale: :en}
        response.should render_template("show") #(campaign_email_path(email.campaign.to_param, email.to_param))
      end
    end

    describe "invalid" do
      it "param" do
        email = create(:email)
        sign_in email.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Email.any_instance.stub(:save).and_return(false)
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {}, locale: :en}
        assigns(:email).should eq(email)
      end
      it "re-renders the 'edit' template" do
        email = create(:email)
        sign_in email.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Email.any_instance.stub(:save).and_return(false)
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {}, locale: :en}
        response.should render_template("edit")
      end
      it "no login" do
        email = create(:email)
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {subject: "Updated"}, locale: :en}
        response.should redirect_to(new_user_session_path)
      end
      it "no autorized" do
        email = create(:email)
        email2 = create(:email)
        sign_in email2.campaign.user
        put :update, {campaign_id: email.campaign.to_param, id: email.to_param, email: {subject: "Updated"}, locale: :en}
        response.response_code.should == 401
      end
    end
  end

  describe "destroy" do
    it "email" do
      email = create(:email)
      sign_in email.campaign.user
      expect {
        delete :destroy, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      }.to change(Email, :count).by(-1)
    end
    it "redirects to the emails list" do
      email = create(:email)
      sign_in email.campaign.user
      delete :destroy, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.should redirect_to(campaign_emails_path(email.campaign))
    end
    it "no login" do
      email = create(:email)
      delete :destroy, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      email = create(:email)
      email2 = create(:email)
      sign_in email2.campaign.user
      delete :destroy, {campaign_id: email.campaign.to_param, id: email.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "getlog" do
    it "get last log" do
      email = create(:email)
      email.mail_me!
      sign_in email.campaign.user
      put :getlog, {campaign_id: email.campaign.to_param, id: email.to_param, email: {idlog: email.logs.last.to_param}, locale: :en}
    end
    it "no login" do
      email = create(:email)
      put :getlog, {campaign_id: email.campaign.to_param, id: email.to_param, email: {idlog: email.logs.last.to_param}, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      email = create(:email)
      email2 = create(:email)
      sign_in email2.campaign.user
      put :getlog, {campaign_id: email.campaign.to_param, id: email.to_param, email: {idlog: email.logs.last.to_param}, locale: :en}
      response.response_code.should == 401
    end
  end
end
