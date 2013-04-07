class Api::V1::SingersController < Api::ApiController

  def index
    # item = SingerSearchWayItem.select("id").find(params[:serch_item_id])
    # singers = item.singers
    # Singer.includes(:singer_search_way_item_relations).where("singer_search_way_item_relations.singer_search_way_item_id = 1")
    
    ids = SingerSearchWayItemRelation.where("singer_search_way_item_id = #{params[:serch_item_id]}").select("singer_id").map{|r| r.singer_id }
    singers = Singer.select("id, name").where("id in (#{ids.join(",")})").paginate(:page => params[:page], :per_page => 30)
    render :json => singers
  end

  def show
    singer = Singer.select("id,name,description").find(params[:id])
    render :json => singer
  end

  def hot_singers
    singers = Singer.select("id, name").where("singer_category_id = #{params[:singer_category_id]} and is_hot = true").paginate(:page => params[:page], :per_page => 30)
    render :json => singers
  end
end
