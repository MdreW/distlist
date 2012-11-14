require 'spec_helper'

describe Address do
  describe "Method" do
    it "recipient" do
      address = create(:address)
      address.recipient.should eql "#{address.name} #{address.surname} <#{address.email}>"
    end
    it "div" do
      address = create(:address)
      address.div.should eql "address_" + address.to_param
    end
    it "pepper" do
      address = create(:address)
      address.pepper.gsub(/\s+/, "").length.should eql 50
    end
    it "replace" do
      address = create(:address, :email => "replaced_email@distlist.it", :name => "replaced_name", :surname => "replaced_surname", :options_attributes => [{:key => "lkey1", :value => "value1"},{:key => "lkey2", :value => "value2"}])
      text = "Hallo {name} {surname} <{email}>, {lkey1} {lkey2}"
      textreplaced = "Hallo replaced_name replaced_surname <replaced_email@distlist.it>, value1 value2"
      address.replace(text).should eql textreplaced
    end
    it "active success" do
      address = create(:address, :inactive => false, :fail_count => 2)
      address.active?.should eql true
    end
    it "active fail 1" do
      address = create(:address, :fail_count => 3)
      address.active?.should_not eql true
    end
    it "active fail 2" do
      address = create(:address, :inactive => true)
      address.active?.should_not eql true
    end
    it "sending_result(true)" do
      address = create(:address)
      address.sending_result(true)
      address.fail_count.should eql 0
    end
    it "sending_result(false)" do
      address = create(:address)
      address.sending_result(false)
      address.fail_count.should eql 1
    end
    it "inactive! (true)" do
      address = create(:address, :inactive => true)
      address.inactive!
      address.inactive.should eql true
    end
    it "inactive! (false)" do
      address = create(:address, :inactive => false)
      address.inactive!
      address.inactive.should eql true
    end
    it "reset!" do
      address = create(:address, :inactive => true, :fail_count => 3)
      address.reset!
      address.inactive.should_not eql true
      address.fail_count.should eql 0
    end
  end

  describe "Protected attribute" do
    it { Address.accessible_attributes.include?('campaign_id').should eql false }
    it { Address.accessible_attributes.include?('id').should eql false }
    it { Address.accessible_attributes.include?('pepper').should eql false }
  end
end
