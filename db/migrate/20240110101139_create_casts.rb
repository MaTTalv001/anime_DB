class CreateCasts < ActiveRecord::Migration[7.1]
  def change
    create_table :casts do |t|
      t.integer :cast_id, null:false
      t.integer :sort_number, null:false
      t.integer :work_id, null:false
      t.integer :person_id, null:false
      t.string :character_name, null:false
      t.string :character_name_kana, null:false

      t.timestamps
    end
  end
end
