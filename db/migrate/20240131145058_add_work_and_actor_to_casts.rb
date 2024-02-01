class AddWorkAndActorToCasts < ActiveRecord::Migration[7.1]
  def change
    # 作品の外部キーを追加
    add_reference :casts, :work, null: false, foreign_key: true
    
    # 役者の外部キーを追加、カラム名をperson_idに指定
    add_reference :casts, :actor, null: false, foreign_key: true, column: :person_id
  end
end
