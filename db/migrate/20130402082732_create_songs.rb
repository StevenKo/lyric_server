class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :album_id
      t.integer :singer_id
      t.integer :hot_song_category_id
      t.string :link
      t.text :lyric

      t.timestamps
    end
    add_index :songs, :singer_id
    add_index :songs, :name
    add_index :songs, :album_id
    add_index :songs, :hot_song_category_id
    add_index :songs, :link
  end
end
