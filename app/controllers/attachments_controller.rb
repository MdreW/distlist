class AttachmentsController < ApplicationController
  before_filter :authenticate_user!, except: ['public'] 
  before_filter :prerequisite, except: ['public']

  def show
    @attachment = @email.attachments.find(params[:id])
    send_file(@attachment.file.path, {type: @attachment.file.content_type})
  end

  def create
    @attachment = @email.attachments.new(params[:attachment])

    respond_to do |format|
      if @attachment.save
        format.js
        format.html {redirect_to campaign_email_path(@campaign, @email)}
      else
        format.html {redirect_to campaign_email_path(@campaign, @email) }
      end
    end
  end

  def destroy
    @attachment = @email.attachments.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.js
      format.html {redirect_to campaign_email_path(@campaign, @email)}
    end
  end

  def public
    @attachment = Attachment.find(params[:id])
    @attachment.atype == 'offline' ? send_file(@attachment.file.path, {type: @attachment.file.content_type}) : record_not_found
  end
 
  private

  def prerequisite
    @submenu = true
    @campaign = current_user.campaigns.find(params[:campaign_id])
    @email = @campaign.emails.find(params[:email_id])
  end
end
