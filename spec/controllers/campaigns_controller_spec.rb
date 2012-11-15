require 'spec_helper'

describe CampaignsController do

  describe "GET index" do
    it "Assigns user campaigns as @campaigns" do
      user = create(:user)
      sign_in user
      create(:campaign, user: user)
      get :index, {locale: :en}
      assigns(:campaigns).should eq(user.campaigns.all)
    end
    it "Try to access without login" do
      get :index, {locale: :en}
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "get show" do
    it "assigns the requested campaign as @campaign" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign, user: user)
      get :show, {id: campaign.to_param, locale: :en}
      assigns(:campaign).should eq(user.campaigns.find(campaign.to_param))
    end
    it "try to access without login" do
      campaign = create(:campaign)
      get :show, {id: campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "try to access in the other user campaign's" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign)
      get :show, {id: campaign.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "get new" do
    it "assigns a new campaign as @campaign" do
      user = create(:user)
      sign_in user
      get :new, {locale: :en}
      assigns(:campaign).should be_a_new(Campaign).with(time_gap: 0, user_id: user.id.to_i)
    end
    it "try to access without login" do
      get :new, {locale: :en}
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "get edit" do
    it "assigns the requested campaign as @campaign" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign, user: user)
      get :edit, {id: campaign.to_param, locale: :en} 
      assigns(:campaign).should eq(campaign)
    end
    it "try to access without login" do
      campaign = create(:campaign)
      get :edit, {id: campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "try to access in the other user campaign's" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign)
      get :edit, {id: campaign.to_param, locale: :en}
      response.response_code.should == 401
    end

  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Campaign" do
        user = create(:user)
        sign_in user
        expect {
          post :create, {campaign: attributes_for(:campaign), locale: :en}
        }.to change(Campaign, :count).by(1)
      end
      it "assigns a newly created campaign as @campaign" do
        user = create(:user)
        sign_in user
        post :create, {campaign: attributes_for(:campaign), locale: :en}
        assigns(:campaign).should be_a(Campaign)
        assigns(:campaign).should be_persisted
      end
      it "redirects to the created campaign" do
        user = create(:user)
        sign_in user
        post :create, {campaign: attributes_for(:campaign), locale: :en}
        response.should redirect_to(Campaign.last)
      end
    end
    describe "with invalid params" do
      it "try to access without login" do
        post :create, {campaign: attributes_for(:campaign), locale: :en}
        response.should redirect_to(new_user_session_path)
      end
      it "assigns a newly created but unsaved campaign as @campaign" do
        user = create(:user)
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        Campaign.any_instance.stub(:save).and_return(false)
        post :create, {campaign: {}, locale: :en}
        assigns(:campaign).should be_a_new(Campaign)
      end
      it "re-renders the 'new' template" do
        user = create(:user)
        sign_in user
        Campaign.any_instance.stub(:save).and_return(false)
        post :create, {campaign: {}, locale: :en}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested campaign" do
        user = create(:user)
        sign_in user
        campaign = create(:campaign, user: user)
        Campaign.any_instance.should_receive(:update_attributes).with({'title' => 'to test'})
        put :update, {:id => campaign.to_param, :campaign => {'title' => 'to test'}, locale: :en}
      end
      it "assigns the requested campaign as @campaign" do
        user = create(:user)
        sign_in user
        campaign = create(:campaign, :user => user)
        put :update, {:id => campaign.to_param, :campaign => attributes_for(:campaign), locale: :en}
        assigns(:campaign).should eq(campaign)
      end
      it "redirects to the campaign" do
        user = create(:user)
        sign_in user
        campaign = create(:campaign, :user => user)
        put :update, {:id => campaign.to_param, :campaign => attributes_for(:campaign), locale: :en}
        response.should redirect_to(campaign)
      end
    end

    describe "with invalid params" do
      it "assigns the campaign as @campaign" do
        user = create(:user)
        sign_in user
        campaign = create(:campaign, :user => user)
        # Trigger the behavior that occurs when invalid params are submitted
        Campaign.any_instance.stub(:save).and_return(false)
        put :update, {:id => campaign.to_param, :campaign => {}, locale: :en}
        assigns(:campaign).should eq(campaign)
      end
      it "re-renders the 'edit' template" do
        user = create(:user)
        sign_in user
        campaign = create(:campaign, :user => user)
        # Trigger the behavior that occurs when invalid params are submitted
        Campaign.any_instance.stub(:save).and_return(false)
        put :update, {:id => campaign.to_param, :campaign => {}, locale: :en}
        response.should render_template("edit")
      end
      it "try to access without login" do
        campaign = create(:campaign)
        put :update, {:id => campaign.to_param, :campaign => {}, locale: :en}
        response.should redirect_to(new_user_session_path)
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested campaign" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign, :user => user)
      expect {
        delete :destroy, {:id => campaign.to_param, locale: :en}
      }.to change(Campaign, :count).by(-1)
    end
    it "redirects to the campaigns list" do
      user = create(:user)
      sign_in user
      campaign = create(:campaign, :user => user)
      delete :destroy, {:id => campaign.to_param, locale: :en}
      response.should render_template('index')
    end
    it "try to access without login" do
      campaign = create(:campaign)
      delete :destroy, {:id => campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
  end
end
