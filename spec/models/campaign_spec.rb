require 'spec_helper'

describe Campaign do
  describe "Method" do
    it "sender" do
      campaign = create(:campaign)
      campaign.sender.should eql "name test <email_test@distlist.com>"
    end
    it "div" do
      campaign = create(:campaign)
      campaign.div.should eql "campaign_" + campaign.to_param 
    end
  end

  describe "protected attribute" do
    it { Campaign.accessible_attributes.include?('user_id').should == false }
    it { Campaign.accessible_attributes.include?('id').should == false }
  end
end
