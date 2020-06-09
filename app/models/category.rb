class Category < ApplicationRecord
    has_many :post_category_relationships, dependent: :destroy
    has_many :posts, through: :post_category_relationships, dependent: :destroy
    
    validates :name, presence: true
end
