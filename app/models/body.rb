class Body < ApplicationRecord
  has_many :unlocked_bodies
  has_many :users, through: :unlocked_bodies
end
