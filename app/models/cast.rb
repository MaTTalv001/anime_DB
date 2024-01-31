class Cast < ApplicationRecord
  belongs_to :work
  belongs_to :actor, primary_key: 'person_id', foreign_key: 'person_id'
end
