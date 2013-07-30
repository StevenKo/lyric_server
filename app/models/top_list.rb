class TopList < ActiveRecord::Base
  has_many :song_top_list_relations
  has_many :songs, :through => :song_top_list_relations

  belongs_to :top_list
  has_many :top_lists
end
