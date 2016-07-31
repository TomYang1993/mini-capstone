class Product < ApplicationRecord
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

  def images
    Image.where(product_id: id)
  end
end
