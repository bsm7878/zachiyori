class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      
      t.integer :menu_id
      t.integer :source_box

      t.timestamps null: false
    end
  end
end
