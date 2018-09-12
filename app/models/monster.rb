class Monster < ApplicationRecord
  belongs_to :user
  validates :body_type, presence: true
  validates_length_of :name, maximum: 25, message: 'too long'
  default_scope { order(created_at: :desc) }

  def created_at_day_year
    created_at.strftime('%b %e, %Y')
  end

  def self.sort_since(monsters, since)
    monsters.where('created_at < ?', Time.at(since))
  end

  def self.sort_username(monsters, username)
    monsters.where(user: User.where(username: username))
  end
end
