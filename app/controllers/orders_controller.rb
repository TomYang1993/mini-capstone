class OrdersController < ApplicationController
  def create
    if current_user
      @order = Order.new(user_id: current_user.id)
      carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
      @order.subtotal = 0
      carted_products.each do |carted_product|
        @order.subtotal += carted_product.quantity * carted_product.product.price
      end
      @order.tax = 0.09 * @order.subtotal
      @order.total = @order.tax + @order.subtotal
      if @order.save
        carted_products.each do |carted_product|
          carted_product.update(order_id: @order.id)
          carted_product.update(status: "purchased")
        end
        flash[:success] = "Your order is ready!"
        redirect_to "/orders/#{@order.id}"
      else
        flash[:danger] = "Danger!!!!"
        redirect_to "/products"
      end
    else
      flash[:warning] = "hey! Wrong page!Please log in!"
      redirect_to "/login"
    end
  end

  def show
    @order = Order.where(user_id: current_user.id)
  end
end
