class Song < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :singer
  belongs_to :album
  belongs_to :hot_song_category

  has_many :recommend_song_relations

  def self.search_name(params)
    tire.search(page: params[:page], per_page: 20) do
      query { string "name: #{params[:keyword]}", default_operator: "AND" }
    end
  end

  def self.search_lyric(params)
    tire.search(page: params[:page], per_page: 20) do
      query { string "lyric:#{params[:keyword]}", default_operator: "AND" }
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :name, :analyzer => "cjk"
    indexes :lyric, :analyzer => "cjk"
  end

end
