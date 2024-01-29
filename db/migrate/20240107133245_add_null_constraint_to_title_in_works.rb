class AddNullConstraintToTitleInWorks < ActiveRecord::Migration[7.1]
  def change
    change_column :works, :title, :string, null: false
  end
end
