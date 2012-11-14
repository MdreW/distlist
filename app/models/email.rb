class Email < ActiveRecord::Base
  belongs_to :campaign
  has_many :addresses, :through => :campaign
  has_many :attachments, :dependent => :destroy
  has_many :logs, :dependent => :destroy
 
  attr_accessor :idlog
  attr_accessible :body, :subject, :idlog

  validates :campaign_id, :presence => true
  validates :body, :presence => true
  validates :subject, :presence => true, :uniqueness => { :scope => :campaign_id}

  scope :sended, where(sended: true)
  scope :not_sended, where("sended is not ?", true)

  def div
    if new_record?
      return "email_new"
    else
      return "email_" + self.to_param
    end
  end

  def sended!
    self.toggle!(:sended) unless self.sended == true
  end

  def mail_me!
    self.sended!
    Thread.new {
      log = self.logs.create!
      self.addresses.each do |address|
        begin
          Postman.to_list(self,address).deliver
          address.sending_result(true)
          log.add_row(address.email,true)
          sleep(self.campaign.time_gap) if self.campaign.time_gap > 0
        rescue
          address.sending_result(false)
          log.add_row(address.email,false)
        end
      end
    }
    return true
  end

  def title
    if new_record?
      return "New Email"
    else
      return "email#" + to_param + " | " + subject
    end
  end
end
