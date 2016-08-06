class Product < ApplicationRecord
  has_many :images
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :carted_products
  has_many :users, through: :carted_products
  has_many :orders, through: :carted_products

  def sale_message
    if price.to_f < 2
      return "On Sale !"
    else
      return "Not On Sale !"
    end
  end

  def tax
    (price.to_f * 0.1).round(2)
  end

  def total
    (price.to_f + tax).round(2)
  end

  def supplier
    Supplier.find_by(id: supplier_id)
  end

  #def images
    #Image.where(product_id: id)
  #end
end
