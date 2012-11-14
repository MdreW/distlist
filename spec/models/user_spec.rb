require 'spec_helper'

describe User do
  describe "Method" do
    it "to_admin!" do
      user = create(:user)
      user.to_admin!
      user.admin.should eql true
    end
    it "no_admin!" do
      user = create(:user)
      user.no_admin!
      user.admin.should_not eql true
    end
    it "div" do
      user = create(:user)
      user.div.should eql "user_" + user.to_param
    end
  end
end
