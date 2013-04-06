class Album < ActiveRecord::Base
  belongs_to :singer
  belongs_to :hot_album_category
  has_many :songs
end
