class CreateSingers < ActiveRecord::Migration
  def change
    create_table :singers do |t|
      t.string :name
      t.text :description
      t.integer :singer_category_id
      t.boolean :is_hot, :default => false
      t.string  :link

      t.timestamps
    end
    add_index :singers, :name
    add_index :singers, :link
    add_index :singers, :singer_category_id
  end
end
