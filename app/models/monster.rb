class Monster < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_by, through: :likes, source: :user
  has_many :monster_tags
  has_many :tags, through: :monster_tags
  validates :body_type, presence: true
  validates_length_of :name, maximum: 25, message: 'too long'

  def tags_attributes=(tags)
    self.tags.delete_all
    tags['names'].each do |tag_name|
      self.tags << Tag.where(name: tag_name).first_or_create
    end
  end

  def created_at_day_year
    self.created_at.strftime('%b %e, %Y')
  end

  # faster to override as_json method and use include instead of doing this?
  def self.monsters_with_associations(monsters)
    monsters_arr = []
    monsters.each do |monster|
      monsters_arr << add_assocations(monster)
    end
    monsters_arr
  end

  def self.monster_with_associations(monster)
    add_assocations(monster)
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
