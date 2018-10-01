class Task < ApplicationRecord
  belongs_to :user, required: true
  has_many :comments, dependent: :destroy

  validates :description, presence: true
end
