class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :campaigns, :dependent => :destroy

  default_scope order('email')
  
  def to_admin!
    toggle!(:admin) unless admin == true
  end

  def no_admin!
    toggle!(:admin) if admin == true
  end

  def div
    return "user_" + to_param
  end

  def emails_counter
    return Email.where(:campaign_id => campaigns.map{|c| c.id}).count
  end

  def addresses_counter
    return Address.where(:campaign_id => campaigns.map{|c| c.id}).count
  end
end
