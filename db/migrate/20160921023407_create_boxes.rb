class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      
      t.integer :menu_id
      t.integer :source_box #소스박스 몇개 공급 했는지

      t.timestamps null: false
    end
  end
end
