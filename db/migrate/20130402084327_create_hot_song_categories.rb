class CreateHotSongCategories < ActiveRecord::Migration
  def change
    create_table :hot_song_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
