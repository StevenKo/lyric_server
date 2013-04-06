class CreateSingerSearchWays < ActiveRecord::Migration
  def change
    create_table :singer_search_ways do |t|
      t.integer :singer_category_id
      t.string :name
      t.string :link
      t.integer :order

      t.timestamps
    end
  end
end
