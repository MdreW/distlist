require 'spec_helper'

describe Log do
  describe "Method" do
    it "div" do
      log = create(:log)
      log.div.should eql "log_" + log.to_param
    end
    it "add_row" do
      log = create(:log)
      count = %x{wc -l #{log.file_path}}.split.first.to_i
      log.add_row("test@distlist.com",true)
      log.row_count.should eql count + 1
      File.exist?("#{Rails.root}/private/log/#{log.email.campaign.to_param}/#{log.email.to_param}/#{log.to_param}.txt").should eql true
      %x{wc -l #{log.file_path}}.split.first.to_i.should eql count + 1
    end
    it "file_path" do
      log = create(:log)
      log.file_path.should eql "#{Rails.root}/private/log/#{log.email.campaign.to_param}/#{log.email.to_param}/#{log.to_param}.txt"
    end
  end
end
