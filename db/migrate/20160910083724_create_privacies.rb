class CreatePrivacies < ActiveRecord::Migration
  def change
    create_table :privacies do |t|
      
      #회원 정보
      t.integer :user_id #user id
      t.string :name #이름
      t.string :phone #전화번호
      t.string :public_pw #공동현관 비밀번호

      t.timestamps null: false
    end
  end
end
