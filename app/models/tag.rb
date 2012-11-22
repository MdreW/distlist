class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :addresses, :through => :taggings
  attr_accessible :mame
end
