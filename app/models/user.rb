class User < ApplicationRecord
  has_many :quizzes, dependent: :restrict_with_error
  has_many :attempts, dependent: :destroy
  before_save :email_downcase
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :role, presence: true, inclusion: { in: %w[regular_user administrator], message: "must be a regular_user" }
  
  private
    def email_downcase
      self.email = email.downcase
    end
end
