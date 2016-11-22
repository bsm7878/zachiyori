class CreateRelaxes < ActiveRecord::Migration
  def change
    create_table :relaxes do |t|

      t.integer :mart_id 
      t.string :relax_date

      t.timestamps null: false
    end
  end
end
