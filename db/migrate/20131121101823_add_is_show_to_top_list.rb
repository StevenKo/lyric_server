class AddIsShowToTopList < ActiveRecord::Migration
  def change
    add_column :top_lists, :is_show, :boolean, default: true
  end
end
