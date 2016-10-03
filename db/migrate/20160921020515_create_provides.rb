class CreateProvides < ActiveRecord::Migration
  def change
    create_table :provides do |t|
      
      t.integer :menu_id
      t.integer :recipe
    
      
      t.timestamps null: false
    end
  end
end
