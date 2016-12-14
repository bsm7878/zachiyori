class CreateMakers < ActiveRecord::Migration
  def change
    create_table :makers do |t|
    
      t.integer :mart_id   #마트id
      t.string :latitude   #위도
      t.string :longitude  #경도
      
      t.timestamps null: false
    end
  end
end
