class Api::V1::SingersController < Api::ApiController

  def index
    item = SingerSearchWayItem.select("id").find(params[:serch_item_id])
    singers = item.singers
    render :json => singers
    # Singer.includes(:singer_search_way_item_relations).where("singer_search_way_item_relations.singer_search_way_item_id = 1")
  end

  def show
    singer = Singer.find(params[:id])
    render :json => singer
  end

  def hot_singers
    singers = Singer.where("singer_category_id = #{params[:singer_category_id]} and is_hot = true")
    render :json => singers
  end
end
