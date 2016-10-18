class CreateReadies < ActiveRecord::Migration
  def change
    create_table :readies do |t|

      t.integer :menu_id
      t.string :ready #필요한거 ex_그릇
      
      t.timestamps null: false
    end
  end
end
