class Api::V1::UsersController < ApplicationController

  def create
    user = find_user
    if user
      user.registration_id = params[:regid];
      user.save
    else
      user = User.new
      user.device_id = params[:device_id]
      user.registration_id = params[:regid]
      user.looked_songs = []
      user.looked_singers = []
      user.looked_albums = []
      user.collected_albums = []
      user.collected_songs = []
      user.collected_singers = []
      user.save
    end
    render :status=>200, :json => {"message" => "success"}
  end

  def update_looked_songs
    song = params[:song]
    user = find_user
    if user
      user.looked_songs << song unless user.looked_songs.include? song
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_looked_singers
    singer = params[:singer]
    user = find_user
    if user
      user.looked_singers << singer unless user.looked_singers.include? singer
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_looked_albums
    album = params[:album]
    user = find_user
    if user
      user.looked_albums << album unless user.looked_albums.include? album
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_songs
    songs = params[:songs]
    user = find_user
    if user
      user.collected_songs = songs
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_albums
    albums = params[:albums]
    user = find_user
    if user
      user.collected_albums = albums
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_singers
    singers = params[:singers]
    user = find_user
    if user
      user.collected_singers = singers
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end
  
  private
    def find_user
      device_id = params[:device_id]
      return nil unless device_id
      user = User.find_by_device_id(device_id)
    end 

end
