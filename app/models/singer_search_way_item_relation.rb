class SingerSearchWayItemRelation < ActiveRecord::Base
  belongs_to :singer
  belongs_to :singer_search_way_item
end
