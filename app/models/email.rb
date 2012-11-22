class Email < ActiveRecord::Base
  belongs_to :campaign
  has_many :addresses, :through => :campaign
  has_many :attachments, :dependent => :destroy
  has_many :logs, :dependent => :destroy
 
  attr_accessor :idlog
  attr_accessible :body, :subject, :idlog, :key_required, :tag_required

  validates :campaign_id, :presence => true
  validates :body, :presence => true
  validates :subject, :presence => true, :uniqueness => { :scope => :campaign_id}
  validates :key_required, :format => { :with => /^[a-z0-9_,\s]*$/, :message => "Only lowercase letters, number, _ allowed" }, :allow_blank => true


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
    sended!
    Thread.new {
      log = logs.create!
      addresses.joins(:tags).where(htag_finder).group(:email).each do |address|
        if key_required.blank? || address.options.map{|o| o.key} & hkey_required == hkey_required
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

  private

  def hkey_required
    return key_required.delete(" ").split(",")
  end

  def htag_finder
    return tag_required.blank? ? nil : {:tags => {:name => tag_required.delete(" ").split(",").compact}}
  end
end
