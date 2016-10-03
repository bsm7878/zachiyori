class CreateReadies < ActiveRecord::Migration
  def change
    create_table :readies do |t|

      t.integer :menu_id
      t.string :ready
      
      t.timestamps null: false
    end
  end
end
