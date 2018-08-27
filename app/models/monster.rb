class Monster < ApplicationRecord
  belongs_to :user
  validates :body_type, presence: true
  validates_length_of :name, maximum: 25, message: 'too long'
end
