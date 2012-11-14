require "spec_helper"

describe Postman do
  describe "to_list" do
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
  end
end
