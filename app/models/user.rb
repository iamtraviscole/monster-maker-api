class User < ApplicationRecord
  has_many :monsters, dependent: :destroy
  has_many :unlocked_bodies
  has_many :bodies, through: :unlocked_bodies
end
