class CartedProductsController < ApplicationController
  def create
    carted_products = CartedProduct.new(
      user_id: current_user.id,
      quantity: params[:quantity],
      product_id: params[:product_id],
      status: "carted"
    )
    if carted_products.save
      flash[:success] = "carted!"
      redirect_to "/checkout"
    else
      flash[:danger] = "WAT!!!"
    end
  end

  def index
    @carted_products = CartedProduct.where(status: "carted", user_id: current_user.id)

  end
end
