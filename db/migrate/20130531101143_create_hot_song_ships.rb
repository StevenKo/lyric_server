class CreateHotSongShips < ActiveRecord::Migration
  def change
    create_table :hot_song_ships do |t|
      t.integer :song_id
      t.integer :hot_song_category_id

      t.timestamps
    end
    add_index :hot_song_ships,:song_id
    add_index :hot_song_ships,:hot_song_category_id
  end
end
