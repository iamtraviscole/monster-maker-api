class User < ApplicationRecord
  has_secure_password
  has_many :monsters, dependent: :destroy
  has_many :unlocked_bodies
  has_many :bodies, through: :unlocked_bodies
  has_many :likes, dependent: :destroy
  has_many :liked_monsters, through: :likes, source: :monster
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}
  validates :username, :email, format: { without: /\s/, message: "must contain no spaces" }
  validates :email, format: /@/
  validates :password, confirmation: {case_sensitive: true}
  validates_length_of :username, within: 3..25, too_long: "too long", too_short: "too short"

  def self.user_with_associations(user)
    user_hash = user.as_json
    user_hash['monsters'] = user.monsters.order(created_at: :desc)
    user_hash
  end
end
