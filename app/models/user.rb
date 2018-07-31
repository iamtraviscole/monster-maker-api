class User < ApplicationRecord
  has_many :monsters, dependent: :destroy
end
