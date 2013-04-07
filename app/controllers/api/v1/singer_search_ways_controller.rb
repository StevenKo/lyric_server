class Api::V1::SingerSearchWaysController < Api::ApiController
  
  def index
    singer_category_id = params[:singer_category_id]
    ways = SingerSearchWay.where("singer_category_id = #{singer_category_id}")
    render :json => ways
  end

end
