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

end
