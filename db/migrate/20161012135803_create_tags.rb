class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end
  end
  def self.down
    drop_table :tags
  end  
end
