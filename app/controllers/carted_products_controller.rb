class CartedProductsController < ApplicationController
  before_action :authenticate_user!

  def create
    carted_products = CartedProduct.new(
      user_id: current_user.id,
      quantity: params[:quantity],
      product_id: params[:product_id],
      status: "carted"
    )
    if params[:quantity].to_i != 0
      carted_products.save
      session[:cart_count] = nil
      flash[:success] = "carted!"
      redirect_to "/checkout"
    else
      flash[:danger] = "WAT or You did not even add a product!!!"
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def index
    if CartedProduct.find_by(status: "carted")
      @carted_products = CartedProduct.where(status: "carted", user_id: current_user.id)
    else
      flash[:danger] = "Cart is empty !!!!"
      redirect_to "/products"
    end
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:carted_product_id])
    carted_product.update(status: "removed")
    session[:cart_count] = nil
    redirect_to "/checkout"
  end
end
