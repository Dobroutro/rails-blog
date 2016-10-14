class SetItemToTags < ActiveRecord::Migration
  def self.up
    create_table :items_tags do |t|
      t.integer :item_id
      t.integer :tag_id
    end    
  end

  def self.down
    drop_table :items_tags
  end
end