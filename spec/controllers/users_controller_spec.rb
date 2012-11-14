require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    describe "success" do
      it "returns http success" do
        user = create(:admin)
        sign_in :user, user
        get :index
        response.should be_success
      end
      it "assign @users" do
        user = create(:admin)
        sign_in :user, user
        get :index
        assigns(:users).should eql(User.all)
      end
    end
    describe "fail" do
      it "no login" do
        get :index
        response.response_code.should == 401
      end
      it "no autorized" do
        user = create(:user)
        sign_in user
        get :index
        response.response_code.should == 401
      end
    end
  end

  describe "GET 'new'" do
    describe "success" do
      it "returns http success" do
        user = create(:admin)
        sign_in :user, user
        get :new
        response.should be_success
      end
      it "assign @users" do
        user = create(:admin)
        sign_in user
        get :new
        assigns(:user).should be_a_new(User)
      end
    end
    describe "fail" do
      it "no login" do
        get :new
        response.response_code.should == 401
      end
      it "no autorized" do
        user = create(:user)
        sign_in user
        get :new
        response.response_code.should == 401
      end
    end
  end


  describe "post 'create'" do
    describe "success" do
      it "valid param" do
        user = create(:admin)
        sign_in user
        expect {
          post :create, {user: attributes_for(:user)}
        }.to change(User, :count).by(1)
      end
      it "@user is persistent" do
        user = create(:admin)
        sign_in user
        post :create, {user: attributes_for(:user)}
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end
      it "redirecto on create" do
        user = create(:admin)
        sign_in user
        post :create, {user: attributes_for(:user)}
        response.should redirect_to(users_path)
      end
    end
    describe "fail" do
      it "invalid param" do
        user = create(:admin)
        sign_in user
        User.any_instance.stub(:save).and_return(false)
        post :create, {user: {}}
        response.should redirect_to(new_user_path)
      end
      it "no login" do
        post :create, {user: attributes_for(:user)}
        response.response_code.should == 401
      end
      it "no autorized" do
        user = create(:user)
        sign_in user
        post :create, {user: attributes_for(:user)}
        response.response_code.should == 401
      end
    end
  end

  describe "PUT 'destroy'" do
    describe "success" do
      it "deleted user" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        expect {
          delete :destroy, {id: user2.to_param}
        }.to change(User, :count).by(-1)
      end
      it "redirect" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        delete :destroy, {id: user2.to_param}
        response.should redirect_to users_path
      end
    end
    describe "fail" do
      it "no login" do
        user = create(:user)
        delete :destroy, {id: user.to_param}
        response.response_code.should == 401
      end
      it "no autorized" do
        user = create(:user)
        user2 = create(:user)
        sign_in user
        delete :destroy, {id: user2.to_param}
        response.response_code.should == 401
      end
    end
  end

  describe "PUT 'swadmin'" do
    describe 'success' do
      it "user to admin" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        put :swadmin, {id: user2.to_param}
        assigns(:user).admin.should eql true
      end
      it "admin to user" do
        user = create(:admin)
        user2 = create(:admin)
        sign_in user
        put :swadmin, {id: user2.to_param}
        assigns(:user).admin.should eql false
      end
      it "redirect" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        put :swadmin, {id: user2.to_param}
        response.should redirect_to(users_path)
      end
    end
    describe 'fail' do
      it 'no login' do
        user = create(:user)
        put :swadmin, {id: user.to_param}
        response.response_code.should == 401
      end
      it 'no autorized' do
        user = create(:user)
        user2 = create(:user)
        sign_in user
        put :swadmin, {id: user2.to_param}
        response.response_code.should == 401
      end
    end
  end

  describe "PUT 'endis'" do
    describe 'success' do
      it "disable user" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        put :endis, {id: user2.to_param}
        assigns(:user).access_locked?.should eql true
      end
      it "enable user" do
        user = create(:admin)
        user2 = create(:admin)
        user2.lock_access!
        sign_in user
        put :endis, {id: user2.to_param}
        assigns(:user).active_for_authentication?.should eql true
      end
      it "redirect" do
        user = create(:admin)
        user2 = create(:user)
        sign_in user
        put :endis, {id: user2.to_param}
        response.should redirect_to(users_path)
      end
    end
    describe 'fail' do
      it 'no login' do
        user = create(:user)
        put :endis, {id: user.to_param}
        response.response_code.should == 401
      end
      it 'no autorized' do
        user = create(:user)
        user2 = create(:user)
        sign_in user
        put :endis, {id: user2.to_param}
        response.response_code.should == 401
      end
    end

  end
end
