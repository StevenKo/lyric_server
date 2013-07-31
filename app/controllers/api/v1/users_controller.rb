class Api::V1::UsersController < ApplicationController

  def create
    regid = params[:regid]
    user = User.find_by_registration_id(regid)
    if user
      user.registration_id = regid;
      user.save
    else
      user = User.new
      user.registration_id = regid
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
    regid = params[:regid]
    song = params[:song]
    user = User.find_by_registration_id(regid)
    if user
      user.looked_songs << song unless user.looked_songs.include? song
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_looked_singers
    regid = params[:regid]
    singer = params[:singer]
    user = User.find_by_registration_id(regid)
    if user
      user.looked_singers << singer unless user.looked_singers.include? singer
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_looked_albums
    regid = params[:regid]
    album = params[:album]
    user = User.find_by_registration_id(regid)
    if user
      user.looked_albums << album unless user.looked_albums.include? album
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_songs
    regid = params[:regid]
    songs = params[:songs]
    user = User.find_by_registration_id(regid)
    if user
      user.collected_songs = songs
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_albums
    regid = params[:regid]
    albums = params[:albums]
    user = User.find_by_registration_id(regid)
    if user
      user.collected_albums = albums
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

  def update_collected_singers
    regid = params[:regid]
    singers = params[:singers]
    user = User.find_by_registration_id(regid)
    if user
      user.collected_singers = singers
      user.save
      render :status=>200, :json => {"message" => "success"}
    else
      render :status=>404, :json => {"message" => "fail"}
    end
  end

end
