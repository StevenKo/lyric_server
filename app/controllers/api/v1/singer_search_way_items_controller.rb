class Api::V1::SingerSearchWayItemsController < Api::ApiController
  def index
    items = SingerSearchWayItem.select("id,name,singer_search_way_id")
    render :json => items
  end
end
