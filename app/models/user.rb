class User < ActiveRecord::Base
  serialize :looked_songs
  serialize :looked_singers
  serialize :looked_albums
  serialize :collected_songs
  serialize :collected_albums
  serialize :collected_singers
end
