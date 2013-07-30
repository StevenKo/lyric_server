class CreateRecommendSongRelations < ActiveRecord::Migration
  def change
    create_table :recommend_song_relations do |t|
      t.integer :recommend_id
      t.integer :song_id

      t.timestamps
    end
    add_index :recommend_song_relations, :recommend_id
    add_index :recommend_song_relations, :song_id
  end
end
