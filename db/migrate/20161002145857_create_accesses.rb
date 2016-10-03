class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|

      t.string :access_email
      t.integer :access_step

      t.timestamps null: false
    end
  end
end
