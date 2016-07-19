class ProductsController < ApplicationController
  def product
    @products = Product.all
  end
end
