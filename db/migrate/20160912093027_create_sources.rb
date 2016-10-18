class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      
      t.integer :menu_id
      t.string :source_name #소스이름
      t.string :source_amount #소스수량
      
      t.timestamps null: false
    end
  end
end
