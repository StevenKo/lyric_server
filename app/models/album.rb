class Album < ActiveRecord::Base
  belongs_to :singer
  belongs_to :hot_album_category
  has_many :songs
  scope :select_id_name_release, select("id,name,release_time")
end
