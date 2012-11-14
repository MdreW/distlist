require 'spec_helper'

describe Option do
  describe "Method" do
    it "div" do
      option = create(:option)
      option.div.should eql "option_" + option.to_param
    end
    it "tkey" do
      option = create(:option, :key => "test")
      option.tkey.should eql "{test}"
    end
    describe "Protected attribute" do
      it { Option.accessible_attributes.include?('address_id').should eql false }
    end
    describe "nested" do
      it "success" do
        expect {
          create(:address)
        }.to change(Option, :count).by(2)
      end
    end
  end
end
