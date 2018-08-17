class User < ApplicationRecord
  has_secure_password
  has_many :monsters, dependent: :destroy
  has_many :unlocked_bodies
  has_many :bodies, through: :unlocked_bodies
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: {case_sensitive: false}
  validates :email, format: /@/
  validates :password, confirmation: {case_sensitive: true}
end
