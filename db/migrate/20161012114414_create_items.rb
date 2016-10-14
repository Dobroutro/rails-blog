class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :heading
      t.text :body
      t.string :image

      t.timestamps null: false
    end
  end
end
