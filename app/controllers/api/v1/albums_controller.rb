class Api::V1::AlbumsController < Api::ApiController

  def index
    singer_id = params[:singer_id]
    albums = Album.where("singer_id = #{singer_id}").select_id_name_release
    render :json => albums
  end

  def show
    album = Album.select("id,name,release_time,description").find(params[:id])
    render :json => album
  end

  def new_albums
    albums = Album.where('is_new = true').select_id_name_release.paginate(:page => params[:page], :per_page => 15)
    render :json => albums
  end

  def hot_albums
    category_id = params[:category_id]
    albums = Album.where("hot_album_category_id = #{category_id}").select_id_name_release
    render :json => albums
  end

  def search
    albums = Album.search(params)
    render :json => albums
  end

end
