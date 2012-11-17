class AddressesController < ApplicationController
  require 'csv'
  before_filter :authenticate_user!, except: [:unsubscribe, :unsubscribe_confirm]
  before_filter :prerequisite, except: [:unsubscribe, :unsubscribe_confirm]

  def index
    @addresses = @campaign.addresses.page(params[:page])
  end

  def new
    @address = @campaign.addresses.new
    5.times {@address.options.build}
  end

  def edit
    @address = @campaign.addresses.find(params[:id])
    5.times { |t| @address.options.build }
  end

  def create
    @address = @campaign.addresses.new(params[:address])

    if @address.save
      redirect_to campaign_addresses_path(@campaign), notice: "Success"
    else
      render action: "new" 
    end
  end

  def update
    @address = @campaign.addresses.find(params[:id])

    if @address.update_attributes(params[:address])
      redirect_to campaign_addresses_path(@campaign), notice: "Success"
    else
      render "edit"
    end
  end

  def import
  end

  def export
    key =  Hash[Option.where(address_id: @campaign.addresses.all.map{|a| a.id}).group(:key).select(:key).map{|o| [o.key,nil]}]
    @csv = CSV.generate do |csv|
      csv << ["email","name","surname"] + key.keys
      @campaign.addresses.each do |address|
        csv << [address.email, address.name, address.surname] + key.merge(Hash[address.options.map{|o| [o.key, o.value]}]).values
      end
    end
    send_data(@csv, :type => 'text/csv; charset=utf-8; header=present', :filename => 'export.csv')  
  end

  def csv
    unless params[:file].blank?
      report = save_csv(params[:file])
      redirect_to campaign_addresses_path(@campaign), notice: "Imported. Error: #{report[:error_counter]} (#{report[:error_row].join(',')})"
    else
      render "import", notice: "Select a file csv"
    end
  end

  def destroy
    @address = @campaign.addresses.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.js
      format.html {redirect_to campaign_addresses_path(@campaign), notice: "Success"}
    end
  end

  def unsubscribe
    @campaign = Campaign.where(:unsubscribe => true).find(params[:campaign_id])
    @address = @campaign.addresses.find_by_pepper(params[:pepper])
  end

  def unsubscribe_confirm
    @campaign = Campaign.where(:unsubscribe => true).find(params[:campaign_id])
    @address = @campaign.addresses.find(params[:id])
    @address.delete if @address.pepper == params[:pepper]
  end

  private

  def prerequisite
    @campaign = current_user.campaigns.find(params[:campaign_id])
  end

  def save_csv(file)
    csv = CSV.parse(file.read, :headers => true)
    counter = 1
    error_counter = 0
    error_row = Array.new
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      address = @campaign.addresses.new(email: row['email'], name: row['name'], surname: row['surname'])
      row.each { |k,v| address.options.build( key: String.new(k).parameterize, value: v ) if !k.blank? && !v.blank? && !['email','name','surname'].include?(String.new(k)) }
      # address = @campaign.addresses.new(email: row['email'], name: row['name'], surname: row['surname'])
      if address.save
        counter = counter.next
      else
        error_counter = error_counter.next
        error_row << counter
        counter = counter.next
      end
    end
    return {error_counter: error_counter, error_row: error_row}
  end
end
