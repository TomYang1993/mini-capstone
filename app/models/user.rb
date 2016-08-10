class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :carted_products
  has_many :products, through: :carted_products

  validates :name, :email, :password, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 8}
end
