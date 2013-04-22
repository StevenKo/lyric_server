class Api::V1::AlbumsController < Api::ApiController

  def index
    singer_id = params[:singer_id]
    @albums = Album.includes(:singer).where("singer_id = #{singer_id}").select_id_name_release
    # render :json => albums
  end

  def show
    @album = Album.includes(:singer).select("id,name,release_time,description,singer_id").find(params[:id])
    # render :json => album
  end

  def new_albums
    @albums = Album.includes(:singer).where('is_new = true').select_id_name_release.paginate(:page => params[:page], :per_page => 15)
    # render :json => albums
  end

  def hot_albums
    category_id = params[:category_id]
    @albums = Album.includes(:singer).where("hot_album_category_id = #{category_id}").select_id_name_release
    # render :json => albums
  end

  def search
    albums_items = Album.search(params)
    render :json => [] unless albums_items.present?
    ids = albums_items.map{|item| item["id"]}.join(",")
    @albums = Album.includes(:singer).where("id in (#{ids})").select_id_name_release
  end

end
