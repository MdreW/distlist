require "spec_helper"

describe Postman do
  describe "to_list (Unsubscrive)" do
    let(:campaign) {create(:campaign, :unsubscribe => true)}
    let(:email) {create(:email, :campaign_id => campaign.to_param)}
    let(:address) {create(:address, :name => 'post', :surname => 'test', :email => 'posttest@distlist.com')}
    let(:mail) { Postman.to_list(email, address) }

    it "renders the headers" do
      mail.subject.should eq("test email for post")
      mail.to.should eq(["posttest@distlist.com"])
      mail.from.should eq(["email_test@distlist.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("<div class='header'>Header Test</div>\r\n<div class='body'>Hi post test, we talk about value1 and value2</div>\r\n<div class='footer'>Footer Test</div>\r\n<div class='unsubscribe'>\r\nFor unsubscribe follow this link:\r\n<a href=\"http://localhost:3000/en/unsubscribe/#{address.campaign.to_param}/#{address.pepper}\">http://localhost:3000/en/unsubscribe/#{address.campaign.to_param}/#{address.pepper}</a>\r\n</div>\r\n")
    end
  end

  describe "to_list (unsubscrive)" do
    let(:email) {create(:email)}
    let(:address) {create(:address, :name => 'post', :surname => 'test', :email => 'posttest@distlist.com')}
    let(:mail) { Postman.to_list(email, address) }

    it "renders the headers" do
      mail.subject.should eq("test email for post")
      mail.to.should eq(["posttest@distlist.com"])
      mail.from.should eq(["email_test@distlist.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("<div class='header'>Header Test</div>\r\n<div class='body'>Hi post test, we talk about value1 and value2</div>\r\n<div class='footer'>Footer Test</div>\r\n")
    end
    it "unsubscribe not in body" do
      mail.body.encoded.should_not match("<div class='unsubscribe'>")
    end
  end

end
