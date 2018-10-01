class Comment < ApplicationRecord
  belongs_to :task, required: true
  belongs_to :user, required: true

  validates :content, presence: true
end
