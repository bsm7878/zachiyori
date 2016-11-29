class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|

      t.integer :menu_id # menu_id => 상품이름
      t.integer :user_id # current_user.id =>이름, 주소, 전화번호, 공동현관 비밀번호
      
      t.string :imp_uid #imp_uid
      t.string :save_time #저장시간
      t.integer :total_price #총가격
      t.string :want_content #요구사항
      t.string :credit_method #결제방법
      t.integer :together_zone #밀집지역
      t.boolean :option_1 #오뚜기밥 주문(0이면 주문안한거 1이면 주문한거)

      t.timestamps null: false
    end
  end
end
