class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :count_cart

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to '/login' unless current_user
  end

  def authorize_admin!
    unless current_user && current_user.admin
      flash[:danger] = "You failed my trust!"
      redirect_to "/products"
    end
  end

  def count_cart
    if current_user
      if session[:cart_count].nil?
        @cart_count = current_user.carted_products.where(status: 'carted').size
        session[:cart_count] = @cart_count
      else
        @cart_count = session[:cart_count]
      end
    end
  end
end
