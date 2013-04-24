class Singer < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  has_many :albums
  has_many :songs
  belongs_to :singer_category

  has_many :singer_search_way_item_relations
  has_many :singer_search_way_items, :through => :singer_search_way_item_relations

  def self.search(params)
    tire.search(page: params[:page], per_page: 24, load: true) do
      query { string params[:keyword], default_operator: "AND" }
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :name, :analyzer => "cjk"
  end

end
