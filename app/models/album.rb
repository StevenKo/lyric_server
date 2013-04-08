class Album < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  belongs_to :singer
  belongs_to :hot_album_category
  has_many :songs
  scope :select_id_name_release, select("id,name,release_time")

  def self.search(params)

    tire.search(page: params[:page], per_page: 20, load: true) do
      query { string params[:keyword], default_operator: "AND" }
      sort{by :id, 'desc'}
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :name, :analyzer => "cjk"
  end

end
