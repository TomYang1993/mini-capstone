class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :carted_products
  has_many :products, through: :carted_products

  validates :subtotal, :tax, :total, presence: true
  validates :subtotal, :tax, :total, numericality: true
end
