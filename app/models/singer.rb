class Singer < ActiveRecord::Base
  has_many :albums
  has_many :songs
  belongs_to :singer_category

  has_many :singer_search_way_item_relations
  has_many :singer_search_way_items, :through => :singer_search_way_item_relations

end
