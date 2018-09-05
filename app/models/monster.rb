class Monster < ApplicationRecord
  belongs_to :user
  validates :body_type, presence: true
  validates_length_of :name, maximum: 25, message: 'too long'

  def created_at_day_year
    created_at.strftime('%b %e, %Y')
  end
end
