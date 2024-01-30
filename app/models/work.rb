class Work < ApplicationRecord
  has_many :persons, through: :casts
end
