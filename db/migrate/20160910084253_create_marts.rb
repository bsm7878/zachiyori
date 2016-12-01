class CreateMarts < ActiveRecord::Migration
  def change
    create_table :marts do |t|
      
      #마트 정보
      
      t.string :mart_name #마트이름
      t.string :mart_email #마트email
      t.string :mart_img #마트대표사진
      t.string :mart_img2 #대표사사진2
      t.string :mart_leader #마트대표이름
      t.string :mart_number #사업자번호
      t.string :agreement_day #협약일
      t.string :mart_address #주소
      t.integer :start_time #시작 시간
      t.integer :end_time #종료 시간
      #t.string :mart_time 운영시간
      t.string :mart_phone #전화번호
      t.integer :bob_price # 오뚜기밥 가격
      t.integer :bob_commission # 오뚜기밥 수수료
      # t.integer :deliver_amount 한타임당 배달가능 건수
      
      t.timestamps null: false
    end
  end
end
