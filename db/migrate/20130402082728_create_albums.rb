class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.datetime :release_time
      t.integer :singer_id
      t.boolean :is_new, :default => false
      t.integer :hot_album_category_id
      t.text :description
      t.string :link

      t.timestamps
    end
    add_index :albums, :singer_id
    add_index :albums, :name
    add_index :albums, :hot_album_category_id
    add_index :albums, :link
  end
end
