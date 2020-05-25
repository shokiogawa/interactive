class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true
  
  has_many :comments
  has_many :user1, through: :comments, source: :user
end
