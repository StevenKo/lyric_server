class RecommendSongRelation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :song
end
