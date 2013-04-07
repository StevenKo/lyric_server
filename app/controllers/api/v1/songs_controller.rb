class Api::V1::SongsController < Api::ApiController
  
  def index
    singer_id = params[:singer_id]
    songs = Song.where("singer_id = #{singer_id}").select("id,name,album_id").paginate(:page => params[:page], :per_page => 30)
    render :json => songs
  end

  def show
     song = Song.select("id,name,album_id,lyric").find(params[:id])
     render :json => song
  end

  def hot_songs
    category_id = params[:category_id]
    songs = Song.where("hot_song_category_id = #{category_id}").select("id,name,album_id").paginate(:page => params[:page], :per_page => 30)
    render :json => songs
  end

end
