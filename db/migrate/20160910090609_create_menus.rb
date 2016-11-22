class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      
      t.integer :mart_id #가게 고유 id => 1:N 설정
      t.string :menu_name # 메뉴 이름
      t.string :menu_say  # 메뉴 한줄평
      t.integer :menu_price # 해당 menu 가격
      t.integer :bob_price # 오뚜기밥 가격
      t.integer :source_box_price # source box 가격
      t.boolean :menu_choice #true면 선택, false면 선택안함
      t.string :menu_img1 # 메뉴사진1
      t.string :menu_img2 # 메뉴사진2
      t.string :menu_img3 # 메뉴사진3
      t.string :menu_img4 # 메뉴사진4
      
      t.timestamps null: false
    end
  end
end
