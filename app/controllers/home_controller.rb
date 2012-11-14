class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:helpdesk]
  before_filter :admin_required!, only: [:admin]
  def index
    redirect_to campaigns_path 
  end

  def helpdesk 
  end
  
  def admin
    redirect_to users_path
  end
end
