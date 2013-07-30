class CreateTopLists < ActiveRecord::Migration
  def change
    create_table :top_lists do |t|
      t.integer :top_list_id
      t.string  :name

      t.timestamps
    end
  end
end
