class SongTopListRelation < ActiveRecord::Base
  belongs_to :song
  belongs_to :top_list
end
