class Article < ApplicationRecord
  has_many :comments
  scope :search_title, ->(keyword) { where('title LIKE ?', "%#{keyword}%") }
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
