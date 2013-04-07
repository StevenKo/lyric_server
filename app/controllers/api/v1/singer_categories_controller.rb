class Api::V1::SingerCategoriesController < Api::ApiController

  def index
    categories = SingerCategory.select("id,name").all
    render :json => categories
  end
end
