require 'spec_helper'
describe AttachmentsController do
  describe "GET show" do
    it "file" do
      attachment = create(:attachment)
      sign_in attachment.email.campaign.user
      get :show, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      assigns(:attachment).should eq(attachment)
    end
    it "no login" do
      attachment = create(:attachment)
      get :show, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      attachment = create(:attachment)
      attachment2 = create(:attachment)
      sign_in attachment2.email.campaign.user
      get :show, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "POST create" do
    describe "valid" do
      it "Attachment" do
        email = create(:email)
        sign_in email.campaign.user
        expect {
          post :create, { campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment), locale: :en}
        }.to change(Attachment, :count).by(1)
      end
      it "@attachment is Attachment" do
        email = create(:email)
        sign_in email.campaign.user
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment), locale: :en}
        assigns(:attachment).should be_a(Attachment)
        assigns(:attachment).should be_persisted
      end
      it "redirects" do
        email = create(:email)
        sign_in email.campaign.user
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment), locale: :en}
        response.should redirect_to(campaign_email_path(email.campaign, email))
      end
    end

    describe "invalid" do
      it "param" do
        email = create(:email)
        sign_in email.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Attachment.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment, file: nil ), locale: :en}
        assigns(:attachment).should be_a_new(Attachment)
      end
      it "to 'new' template" do
        email = create(:email)
        sign_in email.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Attachment.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment, file: nil ), locale: :en}
        response.should redirect_to(campaign_email_path(email.campaign, email))
      end
      it "no login" do
        email = create(:email)
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment), locale: :en}
        response.should redirect_to(new_user_session_path)
      end
      it "no autorized" do
        email = create(:email)
        email2 = create(:email)
        sign_in email2.campaign.user
        post :create, {campaign_id: email.campaign.to_param, email_id: email.to_param, attachment: attributes_for(:attachment), locale: :en}
        response.response_code.should == 401
      end
    end
  end

  describe "destroy" do
    it "requested attachment" do
      attachment = create(:attachment)
      sign_in attachment.email.campaign.user
      expect {
        delete :destroy, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      }.to change(Attachment, :count).by(-1)
    end
    it "redirects" do
      attachment = create(:attachment)
      sign_in attachment.email.campaign.user
      delete :destroy, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      response.should redirect_to(campaign_email_path(attachment.email.campaign, attachment.email))
    end
    it "no login" do
      attachment = create(:attachment)
      delete :destroy, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "not autorized" do
      attachment = create(:attachment)
      attachment2 = create(:attachment)
      sign_in attachment2.email.campaign.user
      delete :destroy, {campaign_id: attachment.email.campaign.to_param, email_id: attachment.email.to_param, :id => attachment.to_param, locale: :en}
      response.response_code.should == 401
    end
  end
end
