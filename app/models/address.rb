class Address < ActiveRecord::Base
  belongs_to :campaign
  has_many :options
  has_many :taggings
  has_many :tags, through: :taggings
  attr_accessible :email, :name, :surname, :tag_list, :options_attributes
  before_validation :add_pepper
  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if => proc {|o| o['key'].blank? or  ['email','name','surname'].include?(o['key']) }
  attr_accessor :status

  validates :campaign_id, :presence => true
  validates :email, :presence => true, :uniqueness => {:scope => :campaign_id}
  validates :fail_count, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :pepper, :presence => true, :format => { :with => /\A[0-9a-f]+\z/ }

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

  def self.tagged_with(name)
    Tag.find_by_name!(name).addresses
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  private

  def add_pepper
    self.pepper = SecureRandom.hex(25) if pepper.blank?
  end
end
