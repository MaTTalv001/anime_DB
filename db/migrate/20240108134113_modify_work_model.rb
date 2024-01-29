class ModifyWorkModel < ActiveRecord::Migration[7.1]
  def change
    add_column :works, :title_kana, :string, null: false
    add_column :works, :twitter_url, :string
    remove_column :works, :episodes_count, :integer
  end
end
