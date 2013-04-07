class Api::V1::SingerCategoriesController < Api::ApiController

  def index
    categories = SingerCategory.all
    render :json => categories
  end
end
