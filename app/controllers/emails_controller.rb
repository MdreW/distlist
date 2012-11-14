class EmailsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prerequisite

  def index
    @emails = Email.page(params[:page])
  end

  def show
    @email = @campaign.emails.find(params[:id])
  end

  def new
    @email = @campaign.emails.new
  end

  def edit
    @email = @campaign.emails.find(params[:id])
  end

  def create
    @email = @campaign.emails.new(params[:email])

    if @email.save
      redirect_to(campaign_email_path(@campaign, @email), notice: "success")
    else
      render action: 'new', notice: 'Error'
    end
  end

  def update
    @email = @campaign.emails.find(params[:id])

    if @email.update_attributes(params[:email])
      render action: 'show', notice: 'success'
    else
      render action: "edit" 
    end
  end

  def destroy
    @email = @campaign.emails.find(params[:id])
    @email.destroy
    redirect_to campaign_emails_path
  end

  def mail_me
    @email = @campaign.emails.find(params[:id])
    @email.mail_me!
    redirect_to campaign_email_path(@email), notice: "Started... What's It Going to Be Today?" 
  end
  
  def getlog
    email = @campaign.emails.find(params[:id])
    sendlog = email.logs.find(params[:email][:idlog])
    send_file(sendlog.file_path, {type: "txt"})
  end

  private

  def prerequisite
    @campaign = current_user.campaigns.find(params[:campaign_id])
  end
end
