class User < ActiveRecord::Base
  serialize :looked_songs
  serialize :looked_singers
  serialize :looked_albums
end
