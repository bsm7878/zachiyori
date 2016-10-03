class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      
      t.integer :mart_id # Mart id 
      t.string :ok_address # 배달 가능 지역
      t.integer :together_zone # 밀집지역 표시

      # t.string :match_mart => 매칭된 마트 이름
      
      
      t.timestamps null: false
    end
  end
end
