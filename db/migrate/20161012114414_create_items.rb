class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :heading
      t.text :body
      t.string :image

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :items
  end  
end
