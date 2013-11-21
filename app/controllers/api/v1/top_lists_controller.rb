class Api::V1::TopListsController < ApplicationController
  def index
    lists = TopList.select("id,name,top_list_id").where(is_show: true)
    render :json => lists
  end
end
