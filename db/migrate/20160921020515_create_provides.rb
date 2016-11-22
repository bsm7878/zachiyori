class CreateProvides < ActiveRecord::Migration
  def change
    create_table :provides do |t|
      
      t.integer :menu_id
      t.integer :recipe #레시피카드&기본세트 몇개 공급 했는지
    
      
      t.timestamps null: false
    end
  end
end
