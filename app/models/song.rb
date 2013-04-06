class Song < ActiveRecord::Base
  belongs_to :singer
  belongs_to :album
  belongs_to :hot_song_category
end
