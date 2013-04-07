class Api::V1::SingerSearchWaysController < Api::ApiController
  
  def index
    ways = SingerSearchWay.select("id,singer_category_id,name")
    render :json => ways
  end

end
