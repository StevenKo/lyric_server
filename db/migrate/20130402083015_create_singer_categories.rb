class CreateSingerCategories < ActiveRecord::Migration
  def change
    create_table :singer_categories do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
