class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # Additional validations
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  
  validates :password, presence: true, 
                       length: { minimum: 6, maximum: 128 },
                       if: :password_required?
                       
  validates :password_confirmation, presence: true, 
                                   if: :password_required?
  
  # Custom methods
  def name
    email.split('@').first.titleize
  end
  
  private
  
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end