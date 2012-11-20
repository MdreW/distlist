require 'spec_helper'

describe Email do
  describe "Method" do
    describe "div" do
      it "new email" do
        campaign = create(:campaign)
        email = campaign.emails.new(attributes_for(:email))
        email.div.should eql "email_new"
      end
      it "persistent email" do
        email = create(:email)
        email.div.should eql "email_" + email.to_param
      end
    end
    it "sended! (false)" do
      email = create(:email, :sended => false)
      email.sended!
      email.sended.should eql true
    end
    it "sended (true)" do
      email = create(:email, :sended => true)
      email.sended!
      email.sended.should eql true
    end
    it "mail_me!" do
      email = create(:email)
      create(:address, :campaign => email.campaign)
      create(:address, :campaign => email.campaign)
      email.mail_me!
      email.sended.should eql true
    end
    describe "title" do
      it "new email" do
        campaign = create(:campaign)
        email = campaign.emails.new(attributes_for(:email))
        email.title.should eql "New Email"
      end
      it "persistent email" do
        email = create(:email, :subject => "test persistent title")
        email.title.should eql "email##{email.id} | test persistent title"
      end
    end
    describe "hkey_required" do
      it "key value nil" do
        email = create(:email)
        email.hkey_required.should eql []
      end
      it "key value full" do
        email = create(:email, :key_required => "casa cane gatto")
        email.hkey_required.should eql ["casa","cane","gatto"]
      end
      it "too whitespace" do
       email = create(:email, :key_required => "casa     cane        gatto")
       email.hkey_required.should eql ["casa","cane","gatto"]
      end
      it "invalid character" do
       email = create(:email)
       email.key_required = "caNe"
       email.save.should eql false
      end
    end
  end
  
  describe "scope" do
    it "sended" do
      create(:email, :sended => true)
      create(:email, :sended => false)
      Email.sended.should match_array( Email.where(:sended => true) )
    end
    it "not sended" do
      create(:email, :sended => true)
      create(:email, :sended => false)
      Email.not_sended.should match_array( Email.where("sended is not ?", true))
    end
  end
  describe "protected attribute" do
    it { Email.accessible_attributes.include?('campaign_id').should_not eql true }
    it { Email.accessible_attributes.include?('sended').should_not eql true }
  end
end
