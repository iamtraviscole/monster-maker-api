class Tag < ApplicationRecord
  has_many :monster_tags
  has_many :monsters, through: :monster_tags
end
