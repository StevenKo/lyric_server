class Api::V1::SingerSearchWayItemsController < Api::ApiController
  def index
    items = SingerSearchWayItem.where("singer_search_way_id = #{params[:singer_search_way_id]}")
    render :json => items
  end
end
