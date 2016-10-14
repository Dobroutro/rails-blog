class AddIndexes < ActiveRecord::Migration
  def change
    add_index :tags, :name, unique: true
    add_index :items_tags, [:item_id, :tag_id], :unique => true
  end
end
