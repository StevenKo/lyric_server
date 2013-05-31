class CreateHotAlbumShips < ActiveRecord::Migration
  def change
    create_table :hot_album_ships do |t|
      t.integer :album_id
      t.integer :hot_album_category_id

      t.timestamps
    end
    add_index :hot_album_ships, :album_id
    add_index :hot_album_ships, :hot_album_category_id
  end
end
