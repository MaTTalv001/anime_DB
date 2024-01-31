class CreateActors < ActiveRecord::Migration[7.1]
  def change
    create_table :actors do |t|
      t.integer :person_id, null: false # person_idは必須
      t.string :name
      t.string :name_en
      t.string :official_site_url
      t.string :twitter_url
      t.date :birthday

      t.timestamps
    end

    # 外部キー制約は、中間テーブルが作成された後に追加
  end
end