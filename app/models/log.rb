class Log < ActiveRecord::Base
  belongs_to :email
  attr_accessible 

  validates :email_id, :presence => true

  before_create :add_email_count
  after_create :test_path

  def div
    return "log_" + self.to_param
  end

  def add_row(address, result)
    File.open(self.file_path, 'a') {|file| file.write [address,result,Time.now].join(";") + "\n"}
    self.row_count = %x{wc -l #{file_path}}.split.first.to_i
    self.save    
  end

  def file_path
    File.join(path, self.to_param + ".txt")
  end

  private

  def add_email_count
    self.email_count = self.email.addresses.count
    self.row_count = 0
  end

  def path
    return Rails.root.join('private', 'log', self.email.campaign.to_param, self.email.to_param)
  end

  def test_path
    FileUtils.mkdir_p(path)
  end

  def label
    return I18n.l( created_at, format: :short )
  end
end
