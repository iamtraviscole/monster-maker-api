class MonsterTag < ApplicationRecord
  belongs_to :monster
  belongs_to :tag
end
