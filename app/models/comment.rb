class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  scope :by_oldest, -> { order('created_at ASC') }
end
