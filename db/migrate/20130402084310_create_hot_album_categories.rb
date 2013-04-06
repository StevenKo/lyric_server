class CreateHotAlbumCategories < ActiveRecord::Migration
  def change
    create_table :hot_album_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
