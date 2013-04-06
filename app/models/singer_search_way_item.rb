class SingerSearchWayItem < ActiveRecord::Base
  belongs_to :singer_search_way

  has_many :singer_search_way_item_relations
  has_many :singers , :through => :singer_search_way_item_relations
end
