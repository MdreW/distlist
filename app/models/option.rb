class Option < ActiveRecord::Base
  belongs_to :address
  attr_accessible :key, :value
  
  validates :key, :presence => true, :format => { :with => /\A[a-zA-Z0-9\-\_]+\z/, :message => "Only letters, number, - , _ allowed" } , :uniqueness => { :scope => :address_id}

  default_scope order(:key)

  def tkey
    return "{" + self.key + "}"
  end

  def div
    return "option_" + self.to_param
  end
end
