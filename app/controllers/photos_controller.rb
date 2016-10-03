class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    @location_hash = Gmaps4rails.build_markers(@photos.where.not(:shot_location_latitude => nil)) do |photo, marker|
      marker.lat photo.shot_location_latitude
      marker.lng photo.shot_location_longitude
      marker.infowindow "<h5><a href='/photos/#{photo.id}'>#{photo.created_at}</a></h5><small>#{photo.shot_location_formatted_address}</small>"
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new
    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.owner_id = params[:owner_id]
    @photo.shot_location = params[:shot_location]

    if @photo.save
      redirect_to "/photos", :notice => "Photo created successfully."
    else
      render 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.owner_id = params[:owner_id]
    @photo.shot_location = params[:shot_location]

    if @photo.save
      redirect_to "/photos", :notice => "Photo updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    @photo.destroy

    redirect_to "/photos", :notice => "Photo deleted."
  end
end
