class CreateWorks < ActiveRecord::Migration[7.1]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :year
      t.string :season
      t.string :image_url
      t.string :official_site_url
      t.integer :annict_id
      t.integer :syobocal_tid
      t.integer :episodes_count

      t.timestamps
    end
  end
end
