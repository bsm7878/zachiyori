class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      
      t.integer :menu_id #메뉴 고유 id => 1:N 설정
      t.string :ingredient_name #재료 이름
      t.integer :ingredient_price #가격
      t.string :ingredient_amount #용량
      t.string :ingredient_country #원산지
      
      t.timestamps null: false
    end
  end
end
