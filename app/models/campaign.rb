class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :addresses, :dependent => :destroy
  has_many :emails, :dependent => :destroy
  attr_accessible :footer, :header, :sender_email, :sender_name, :time_gap, :title

  validates :user_id, :presence => true
  validates :sender_email, :presence => true
  validates :time_gap, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :title, :presence => true, :uniqueness => { :scope => :user_id}

  def sender
    return "#{self.sender_name} <#{self.sender_email}>"
  end

  def div
    return "campaign_" + self.to_param
  end
end
