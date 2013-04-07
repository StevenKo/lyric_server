class Api::V1::AlbumsController < Api::ApiController

  def index
    singer_id = params[:singer_id]
    albums = Album.where("singer_id = #{singer_id}")
    render :json => albums
  end

  def show
    album = Album.find(params[:id])
    render :json => album
  end

  def new_albums
    albums = Album.where('is_new = true')
    render :json => albums
  end

  def hot_albums
    category_id = params[:category_id]
    albums = Album.where("hot_album_category_id = #{category_id}")
    render :json => albums
  end

end
