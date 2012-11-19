require 'spec_helper'

describe AddressesController do

  describe "GET index" do
    it "@addresses" do
      address = create(:address)
      sign_in address.campaign.user
      get :index, {campaign_id: address.campaign.to_param, locale: :en}
      assigns(:addresses).should eq([address])
    end
    it "no login" do
      address = create(:address)
      get :index, {campaign_id: address.campaign.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      address = create(:address)
      address2 = create(:address)
      sign_in address2.campaign.user
      get :index, {campaign_id: address.campaign.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "GET new" do
    it "@address" do
      campaign = create(:campaign)
      sign_in campaign.user
      get :new, {campaign_id: campaign.to_param, locale: :en}
      assigns(:address).should be_a_new(Address)
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
    it "@address" do
      address = create(:address)
      sign_in address.campaign.user
      get :edit, {campaign_id: address.campaign.to_param ,id: address.to_param, locale: :en}
      assigns(:address).should eq(address)
    end
    it "no login" do
      address = create(:address)
      get :edit, {campaign_id: address.campaign.to_param ,id: address.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      address = create(:address)
      address2 = create(:address)
      sign_in address2.campaign.user
      get :edit, {campaign_id: address.campaign.to_param ,id: address.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "POST create" do
    describe "valid" do
      it "param" do
        campaign = create(:campaign)
        sign_in campaign.user
        expect {
          post :create, {campaign_id: campaign.to_param, address: attributes_for(:address), locale: :en}
        }.to change(Address, :count).by(1)
      end
      it "@address persist" do
        campaign = create(:campaign)
        sign_in campaign.user
        post :create, {campaign_id: campaign.to_param, address: attributes_for(:address), locale: :en}
        assigns(:address).should be_a(Address)
        assigns(:address).should be_persisted
      end
      it "redirects to the created address" do
        campaign = create(:campaign)
        sign_in campaign.user
        post :create, {campaign_id: campaign.to_param, address: attributes_for(:address), locale: :en}
        response.should redirect_to(campaign_addresses_path(campaign))
      end
    end

    describe "invalid" do
      it "@address" do
        campaign = create(:campaign)
        sign_in campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: campaign.to_param, address: {}, locale: :en}
        assigns(:address).should be_a_new(Address)
      end
      it "re-renders 'new'" do
        campaign = create(:campaign)
        sign_in campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        post :create, {campaign_id: campaign.to_param, address: {}, locale: :en}
        response.should render_template("new")
      end
      it "no login" do
        campaign = create(:campaign)
        post :create, {campaign_id: campaign.to_param, address: {}, locale: :en}
        response.should redirect_to(new_user_session_path)
      end
      it "no autorized" do
        campaign = create(:campaign)
        campaign2 = create(:campaign)
        sign_in campaign2.user
        post :create, {campaign_id: campaign.to_param, address: attributes_for(:address), locale: :en}
        response.response_code.should == 401
      end
    end
  end

  describe "PUT update" do
    describe "valid" do
      it "@address" do
        address = create(:address)
        sign_in address.campaign.user
        put :update, {campaign_id: address.campaign, id: address.to_param, address: {'name' => 'updated_name'}, locale: :en}
        assigns(:address).name.should eql 'updated_name'
      end
      it "redirects" do
        address = create(:address)
        sign_in address.campaign.user
        put :update, {campaign_id: address.campaign, id: address.to_param, address: {'name' => 'updated_name'}, locale: :en}
        response.should redirect_to(campaign_addresses_path(address.campaign.to_param))
      end
    end

    describe "with invalid params" do
      it "assigns the address as @address" do
        address = create(:address)
        sign_in address.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        put :update, {campaign_id: address.campaign.to_param, id: address.to_param, address: {name: 'updated_name'}, locale: :en}
        assigns(:address).should eq(address)
      end

      it "re-renders the 'edit' template" do
        address = create(:address)
        sign_in address.campaign.user
        # Trigger the behavior that occurs when invalid params are submitted
        Address.any_instance.stub(:save).and_return(false)
        put :update, {campaign_id: address.campaign.user, id: address.to_param, address: {}, locale: :en}
        response.should render_template("edit")
      end
      it "no login" do
        address = create(:address)
        put :update, {campaign_id: address.campaign, id: address.to_param, address: {'name' => 'updated_name'}, locale: :en}
        response.should redirect_to(new_user_session_path)
      end
      it "no autorized" do
        address = create(:address)
        address2 = create(:address)
        sign_in address2.campaign.user
        put :update, {campaign_id: address.campaign, id: address.to_param, address: {'name' => 'updated_name'}, locale: :en}
        response.response_code.should == 401
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested address" do
      address = create(:address)
      sign_in address.campaign.user
      expect {
        delete :destroy, {campaign_id: address.campaign.to_param, id: address.to_param, locale: :en}
      }.to change(Address, :count).by(-1)
    end
    it "redirects to the addresses list" do
      address = create(:address)
      sign_in address.campaign.user
      delete :destroy, {campaign_id: address.campaign.to_param, id: address.to_param, locale: :en}
      response.should redirect_to(campaign_addresses_path(address.campaign))
    end
    it "no login" do
      address = create(:address)
      delete :destroy, {campaign_id: address.campaign.to_param, id: address.to_param, locale: :en}
      response.should redirect_to(new_user_session_path)
    end
    it "no autorized" do
      address = create(:address)
      address2 = create(:address)
      sign_in address2.campaign.user
      delete :destroy, {campaign_id: address.campaign.to_param, id: address.to_param, locale: :en}
      response.response_code.should == 401
    end
  end

  describe "Unsubscribe" do
    describe "success" do
      it "correct param" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        get :unsubscribe, {campaign_id: address.campaign.to_param, pepper: address.pepper, locale: :en}
        assigns(:address).should eql(address)
      end
    end
    describe "fail" do
      it "incorrect campaign_id" do
        campaign = create(:campaign, unsubscribe: true)
        campaign2 = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        get :unsubscribe, {campaign_id: campaign2.to_param, pepper: address.pepper, locale: :en}
        response.response_code.should == 404
      end
      it "incorrect pepper" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        address2 = create(:address)
        get :unsubscribe, {campaign_id: campaign.to_param, pepper: address2.pepper, locale: :en}
        response.response_code.should == 404
      end
    end
  end

  describe "Unsubscribe_confirm" do
    describe "success" do
      it "correct param" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        post :unsubscribe_confirm, {campaign_id: address.campaign.to_param, pepper: address.pepper, id: address.to_param, locale: :en}
        assigns(:address).should eql(address)
      end
      it "address destryed" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        expect {
          post :unsubscribe_confirm, {campaign_id: address.campaign.to_param, pepper: address.pepper, id: address.to_param, locale: :en}
        }.to change(Address, :count).by(-1)
      end
    end
    describe "fail" do
      it "incorrect pepper" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        address2 = create(:address)
        post :unsubscribe_confirm, {campaign_id: address.campaign.to_param, pepper: address2.pepper, id: address.to_param, locale: :en}
      end
      it "incorrect id" do
        campaign = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        address2 = create(:address)
        post :unsubscribe_confirm, {campaign_id: address.campaign.to_param, pepper: address.pepper, id: address2.to_param, locale: :en}
        response.response_code.should == 401
      end
      it "incorrect campaign_id" do
        campaign = create(:campaign, unsubscribe: true)
        campaign2 = create(:campaign, unsubscribe: true)
        address = create(:address, campaign_id: campaign.to_param)
        post :unsubscribe_confirm, {campaign_id: campaign2.to_param, pepper: address.pepper, id: address.to_param, locale: :en}
        response.response_code.should == 401
      end
      it "Unsubscrive not active" do
        campaign = create(:campaign, unsubscribe: false)
        address = create(:address, campaign_id: campaign.to_param)
        post :unsubscribe_confirm, {campaign_id: campaign.to_param, pepper: address.pepper, id: address.to_param, locale: :en}
        response.response_code.should == 401
      end
    end
  end
end
