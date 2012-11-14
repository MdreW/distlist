class Address < ActiveRecord::Base
  belongs_to :campaign
  has_many :options
  attr_accessible :email, :name, :surname, :options_attributes
  before_save :add_pepper
  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if => proc {|o| o['key'].blank? or  ['email','name','surname'].include?(o['key']) }
  attr_accessor :status

  validates :campaign_id, :presence => true
  validates :email, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :fail_count, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

  default_scope order(:email)

  def recipient
    return [(name unless name.blank?), (surname unless surname.blank?),"<#{email}>"].compact.join(" ")
  end

  def div
    return new_record? ? "address_new" : "address_" + to_param
  end

  def replace(text)
    reg = Regexp.new("({name}|{surname}|{email}|" +  self.options.map{|o| o.tkey}.join('|') + ")")
    value = {"{name}" => self.name, "{surname}" => self.surname, "{email}" => self.email}.merge( Hash[self.options.map{|o| [o.tkey,o.value]}] )
    return text.gsub(reg, value)
  end

  def sending_result(status)
    if status == true
      self.decrement(:fail_count, 1) unless self.fail_count < 1
    else
      self.increment(:fail_count, 1)
    end
  end

  def active?
    return true if self.fail_count < 3 && self.inactive == false
  end

  def inactive!
    self.toggle!(:inactive) unless self.inactive == true
  end

  def reset!
    self.inactive = false
    self.fail_count = 0
    self.save
  end

  private

  def add_pepper
    self.pepper = SecureRandom.hex(25) unless self.pepper.length == 50
  end
end
