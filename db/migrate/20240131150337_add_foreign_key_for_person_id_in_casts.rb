class AddForeignKeyForPersonIdInCasts < ActiveRecord::Migration[7.1]
  def change
    #add_foreign_key :casts, :actors, column: :person_id
  end
end
