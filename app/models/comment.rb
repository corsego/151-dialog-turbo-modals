class Comment < ApplicationRecord
  validates :body, presence: true
end
