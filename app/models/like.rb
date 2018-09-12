class Like < ApplicationRecord
  belongs_to :user
  belongs_to :monster
  validates :user_id, uniqueness: { scope: :monster_id }
end
