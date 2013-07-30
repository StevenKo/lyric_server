class CreateSongTopListRelations < ActiveRecord::Migration
  def change
    create_table :song_top_list_relations do |t|
      t.integer :top_list_id
      t.integer :song_id

      t.timestamps
    end
  end
end
