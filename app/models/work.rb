class Work < ApplicationRecord
  has_many :casts, foreign_key: 'person_id'
  has_many :actors, through: :casts
end
