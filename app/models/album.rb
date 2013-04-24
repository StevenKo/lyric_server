class Album < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  belongs_to :singer
  belongs_to :hot_album_category
  has_many :songs
  scope :select_id_name_release, select("id,name,release_time,singer_id")

  def self.search(params)

    tire.search(page: params[:page], per_page: 20) do
      query { string params[:keyword], default_operator: "AND" }
      sort{by :release_time, 'desc'}
    end
  end

  mapping do
    indexes :name, :analyzer => "cjk"
    indexes :release_time,      :type     => 'date', :index => 'not_analyzed', :include_in_all => false
  end

end
