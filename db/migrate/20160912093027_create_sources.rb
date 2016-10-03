class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      
      t.integer :menu_id
      t.string :source_name
      #t.string :source_amount
      
      
      t.timestamps null: false
    end
  end
end
