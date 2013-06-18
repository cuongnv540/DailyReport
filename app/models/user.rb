class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation , :active , :manager, :group_id
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :report 

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@framgia.com\z/i
  validates :email, presence:   true, # xem thuoc tinh nay co bat buoc ton tai ko
                    #format:     { with: VALID_EMAIL_REGEX }, #dinh dang theo format
                    uniqueness: { case_sensitive: false } #dinh dang email khong dc trung lap
  validates :password, presence: true, length: { minimum: 6 }
  # pass phai ton tai
  validates :password_confirmation, presence: true

  default_scope order: 'users.created_at DESC' #Xap sep user theo thu tu tao

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end