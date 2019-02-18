class User < ApplicationRecord
  include ReservedPaths

  has_secure_password
  has_many :monsters, dependent: :destroy
  has_many :unlocked_bodies
  has_many :bodies, through: :unlocked_bodies
  has_many :likes, dependent: :destroy
  has_many :liked_monsters, through: :likes, source: :monster
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  validates :username, :email, format: { without: /\s/, message: "must contain no spaces" }
  validates :email, format: /@/
  validates :password, confirmation: { case_sensitive: true }
  validates_length_of :username, within: 3..25, too_long: "too long", too_short: "too short"
  validates :username, exclusion: { in: ReservedPaths.paths }

# faster to override as_json method and use include instead of doing this?
  def self.user_with_associations(user)
    user_monsters = user.monsters.includes(:liked_by, :tags).order(created_at: :desc)
    monsters_arr = []
    user_monsters.each do |monster|
      monsters_arr << add_assocations(monster)
    end
    user_hash = user.as_json
    user_hash.except!('email', 'password_digest')
    user_hash['liked_monsters'] = user.liked_monsters.order(created_at: :desc)
    user_hash['monsters'] = monsters_arr
    user_hash
  end

  private

  def self.add_assocations(monster)
    monster_hash = monster.as_json
    monster_hash['username'] = monster.user.username
    monster_hash['liked_by'] = []
    monster.liked_by.each do |user|
      monster_hash['liked_by'] << user.username
    end
    monster_hash['created_at_day_year'] = monster.created_at_day_year
    monster_hash['like_count'] = monster.liked_by.length
    monster_hash['tags'] = []
    monster.tags.each do |tag|
      monster_hash['tags'] << tag.name
    end
    monster_hash
  end

end
