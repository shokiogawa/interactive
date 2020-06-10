class User < ApplicationRecord
    attr_accessor :remember_token
    
    before_save { self.email.downcase! }
    has_secure_password
    #validates :password, presence: true, length: { minimum: 6 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    validates :language1_id, presence: true
    validates :language_id, presence: true
    
                    
   mount_uploader :image, ImageUploader
   
   has_many :posts, dependent: :destroy
   
   has_many :relationships
   has_many :followings, through: :relationships, source: :follow
   has_many :r_relationships, class_name: "Relationship", foreign_key: "follow_id"
   has_many :followers, through: :r_relationships, source: :user
   
   
   def follow(other_user)
       unless self == other_user
       self.relationships.find_or_create_by(follow_id: other_user.id)
       end
   end
   
   def unfollow(other_user)
       relationship = self.relationships.find_by(follow_id: other_user.id)
       relationship.destroy if relationship
   end
   
   def following?(other_user)
       self.followings.include?(other_user)
   end
   
   has_many :comments, dependent: :destroy
   has_many :post1, through: :comments, source: :post, dependent: :destroy
   
   belongs_to :language, optional: true
   belongs_to :language1, optional: true
   
   def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
   end
   
   def self.new_token
    SecureRandom.urlsafe_base64
   end
   
   def remember
    self.remember_token = User.new_token
    return false if remember_digest.nil?
    update_attribute(:remember_digest, User.digest(remember_token))
   end
    
   def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
   end
   
   def forget
    update_attribute(:remember_digest, nil)
   end
    
    
    
end
