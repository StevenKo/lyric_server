class SingerCategory < ActiveRecord::Base
  has_many :singer_search_ways
  has_many :singers
end
