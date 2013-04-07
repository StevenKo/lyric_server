class Api::V1::SongsController < Api::ApiController
  
  def index
    singer_id = params[:singer_id]
    songs = Song.where("singer_id = #{singer_id}").paginate(:page => params[:page], :per_page => 15)
    render :json => songs
  end

  def hot_songs
    category_id = params[:category_id]
    songs = Song.where("hot_song_category_id = #{category_id}")
    render :json => songs
  end

end
