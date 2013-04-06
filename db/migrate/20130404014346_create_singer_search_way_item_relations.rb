class CreateSingerSearchWayItemRelations < ActiveRecord::Migration
  def change
    create_table :singer_search_way_item_relations do |t|
      t.integer :singer_id
      t.integer :singer_search_way_item_id


      t.timestamps
    end
  end
end
