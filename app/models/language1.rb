class Language1 < ApplicationRecord
    has_many :users
    
    validates :lang1, presence: true
    
    
end
