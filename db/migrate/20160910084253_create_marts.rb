class CreateMarts < ActiveRecord::Migration
  def change
    create_table :marts do |t|
      
      #마트 정보
      
      t.string :mart_name #마트이름
      t.string :mart_email #마트email
      t.string :mart_img #마트대표사진
      t.string :mart_leader #마트대표이름
      t.string :mart_number #사업자번호
      t.string :agreement_day #협약일
      t.string :mart_address #주소
      t.string :mart_time #운영시간
      t.string :mart_phone #전화번호
      t.string :mart_img1 #마트 사진1  
      t.string :mart_img2 #마트 사진2  

      
      t.timestamps null: false
    end
  end
end
