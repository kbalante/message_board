class Post < ApplicationRecord
  has_many :comments, dependent: :delete_all
  belongs_to :user

  validates :title, presence: true

  scope :by_most_recent, -> { order('created_at DESC') }
end
