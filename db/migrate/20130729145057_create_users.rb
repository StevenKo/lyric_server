class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :registration_id
      t.text :looked_songs
      t.text :looked_singers
      t.text :looked_albums
      t.text :collected_songs
      t.text :collected_albums
      t.text :collected_singers

      t.timestamps
    end
  end
end
