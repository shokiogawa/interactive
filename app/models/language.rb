class Language < ApplicationRecord
    has_many :users 
    
    validates :lang2, presence: true
end
