class Work < ApplicationRecord
  has_many :casts
  has_many :actors, through: :casts
end
