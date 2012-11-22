class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :address
  # attr_accessible :title, :body
end
