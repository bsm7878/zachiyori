class CreateHowtos < ActiveRecord::Migration
  def change
    create_table :howtos do |t|
      
      t.integer :menu_id
      t.string :howto_img
      
      t.timestamps null: false
    end
  end
end
