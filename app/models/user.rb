class User < ApplicationRecord
  has_many :tasks, :comments
  has_secure_password
end
