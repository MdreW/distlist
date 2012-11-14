require 'spec_helper'

describe Attachment do
  describe "Method" do
    it "div" do
      attachment = create(:attachment)
      attachment.div.should eql "attachment_" + attachment.to_param
    end
  end
  describe "Protected attribute" do
    it { Attachment.accessible_attributes.include?('email_id').should_not eql true }
  end
  describe "scope" do
    it "inline" do
      email = create(:email)
      a1 = create(:attachment, :email => email, :atype => 'inline')
      a2 = create(:attachment, :email => email, :atype => 'attached')
      a3 = create(:attachment, :email => email, :atype => 'offline')
      email.attachments.inline.should match_array([a1])
    end
    it "attached" do
      email = create(:email)
      a1 = create(:attachment, :email => email, :atype => 'inline')
      a2 = create(:attachment, :email => email, :atype => 'attached')
      a3 = create(:attachment, :email => email, :atype => 'offline')
      email.attachments.attached.should match_array([a2])
    end
  end
end
