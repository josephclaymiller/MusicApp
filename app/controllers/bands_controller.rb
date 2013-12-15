class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end
  
  def show
    @band = Band.find_by_id(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def create
    @band = Band.create(params[:band])
    if @band.save!
      flash[:message] = "Successfully created band #{@band.name}"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end
  
  def edit
    @band = Band.find_by_id(params[:id])
    render :edit
  end
  
  def update
    @band = Band.find_by_id(params[:id])
    @band.update_attributes(params[:band])
    if @band.save!
      flash[:message] = "Successfully edited band #{@band.name}"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @band = Band.find_by_id(params[:id])
    @band_name = @band.name
    @band.delete
    if @band.save!
      flash[:message] = "Successfully deleted band #{@band_name}."
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
    end
      
  end
end
