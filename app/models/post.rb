class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true
  
  has_many :comments, dependent: :destroy
  has_many :user1, through: :comments, source: :user, dependent: :destroy
  
  has_many :post_category_relationships, dependent: :destroy
  has_many :categorys, through: :post_category_relationships, dependent: :destroy
end
