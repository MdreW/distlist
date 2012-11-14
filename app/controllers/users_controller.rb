class UsersController < ApplicationController
  before_filter :admin_required!
  before_filter :prerequisite, only: [:index, :new, :create] 

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, notice: "success"
    else
      render :new
      #redirect_to new_user_path, notice: "Fail: " + @user.errors.messages.inject([]){|nemo,(k,v)| nemo << [k,": ",v].join; nemo}.join(", ")
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "success"
  end

  def endis
    @user = User.find(params[:id])
    @user.access_locked? ? @user.unlock_access! : @user.lock_access!
    redirect_to users_path, notice: "success"
  end

  def swadmin
    @user = User.find(params[:id])
    @user.admin? ? @user.no_admin! : @user.to_admin!
    redirect_to users_path, notice: "success"
  end
  
  private
  
  def prerequisite
    @user_count = User.all.count
    @campaign_count = Campaign.all.count
    @email_count = Email.all.count
    @address_count = Address.all.count
    @sended_count = Log.sum(:row_count)
  end
end
