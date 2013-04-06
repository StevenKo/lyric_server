class CreateSingerSearchWayItems < ActiveRecord::Migration
  def change
    create_table :singer_search_way_items do |t|
      t.integer :singer_search_way_id
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
