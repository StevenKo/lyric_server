class Api::V1::SongsController < Api::ApiController
  
  def index
    singer_id = params[:singer_id]
    @songs = Song.includes(:singer).where("singer_id = #{singer_id}").select("id,name,album_id,singer_id").paginate(:page => params[:page], :per_page => 30)
    # render :json => @songs
  end

  def show
     @song = Song.includes(:singer).select("id,name,album_id,lyric,singer_id").find(params[:id])
     # render :json => song
  end

  def hot_songs
    category_id = params[:category_id]
    if category_id.to_i == 4
      category_id = 5
    elsif category_id.to_i == 5
      category_id = 4
    end
    @songs = Song.includes(:singer).where("hot_song_category_id = #{category_id}").select("id,name,album_id,singer_id").paginate(:page => params[:page], :per_page => 30)
  end

  def search_name
    songs = Song.search_name(params)
    if songs.present?
      ids = songs.map{|item| item["id"]}.join(",")
      @songs = Song.includes(:singer).where("id in (#{ids})").select("id,name,album_id,singer_id")
    else
      render :json => []
    end
  end

  def search_lyric
    songs = Song.search_lyric(params)
    if songs.present?
      ids = songs.map{|item| item["id"]}.join(",")
      @songs = Song.includes(:singer).where("id in (#{ids})").select("id,name,album_id,singer_id")
    else
      render :json => []
    end
  end

  def album_songs
    album_id = params[:album_id]
    @songs = Song.includes(:singer).where("album_id = #{album_id}").select("id,name,album_id,singer_id")
    # render :json => songs
  end

end
