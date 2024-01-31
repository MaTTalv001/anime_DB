class CreateCasts < ActiveRecord::Migration[7.1] 
 def change
    create_table :casts do |t|
      t.integer :work_id, null: false
      t.integer :cast_id, null: false
      t.integer :sort_number
      t.integer :person_id, null: false
      t.string :character_name
      t.string :character_name_kana

      t.timestamps
    end
  end
end
