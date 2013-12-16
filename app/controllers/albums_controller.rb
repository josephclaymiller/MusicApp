class AlbumsController < ApplicationController
  def index
    @albums = Album.where(:band_id => params[:id])
    @band = Band.find_by_id(params[:id])
    render :index
  end
  
  def show
    @album = Album.find_by_id(params[:id])
    @band = Band.find_by_id(@album.band_id)
    render :show
  end
  
  def new
    render :new
  end
  
  def create
    @album = Album.create(params[:album])
    @album.band_id = params[:id]
    if @album.save!
      flash[:message] = "Successfully created album #{@album.title}"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def edit
    @album = Album.find_by_id(params[:id])
    render :edit
  end
  
  def update
    @album = Album.find_by_id(params[:id])
    @album.update_attributes(params[:album])
    if @album.save!
      flash[:message] = "Successfully edited album #{@album.title}"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @album = Album.find_by_id(params[:id])
    @album_title = @album.title
    @album.delete
    if @album.save!
      flash[:message] = "Successfully deleted album #{@album_title}."
      redirect_to albums_url
    else
      flash.now[:errors] = @album.errors.full_messages
    end
  end
end
