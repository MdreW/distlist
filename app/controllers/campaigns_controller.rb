class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  # GET /campaigns
  def index
    @campaigns = current_user.campaigns.page(params[:page])
    @address_count = Address.where(campaign_id: @campaigns.map{|c| c.id}).count
    @email_count = Email.where(campaign_id: @campaigns.map{|c| c.id}).count
  end

  # GET /campaigns/1
  def show
    @campaign = current_user.campaigns.find(params[:id])
  end

  # GET /campaigns/new
  def new
    @campaign = current_user.campaigns.new
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = current_user.campaigns.find(params[:id])
  end

  # POST /campaigns
  def create
    @campaign = current_user.campaigns.new(params[:campaign])

    if @campaign.save
      redirect_to @campaign, notice: 'Campaign was successfully created.'
    else
      render action: "new" 
    end
  end

  # PUT /campaigns/1
  def update
    @campaign = current_user.campaigns.find(params[:id])

    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, notice: 'Campaign was successfully updated.'
    else
      render action: "edit" 
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign = current_user.campaigns.find(params[:id])
    if @campaign.destroy
      @campaigns = current_user.campaigns.all
      render action: "index"
    else
      render action: "show"
    end
  end

  def unsibscribe
  end

  def unsubscribe_confirm
  end
end
