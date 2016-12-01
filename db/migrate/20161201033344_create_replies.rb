class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      t.integer :menu_id #어떤메뉴
      t.integer :user_id #누가댓글
      t.string :reply_img #사진!
      t.string :reply_content #한줄평

      t.timestamps null: false
    end
  end
end
