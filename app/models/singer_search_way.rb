class SingerSearchWay < ActiveRecord::Base
  has_many :singer_search_way_items
  belongs_to :singer_category
end
