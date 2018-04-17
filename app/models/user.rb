class User < ActiveRecord::Base
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, confirmation: true
  before_create do
    self.email = email.downcase
  end
end
