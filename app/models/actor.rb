class Actor < ApplicationRecord
  self.primary_key = 'person_id'
  has_many :casts, foreign_key: 'person_id'
  has_many :works, through: :casts
end
