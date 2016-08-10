class SessionsController < ApplicationController
  def new
    render "new.html.erb"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to '/products'
    else
      flash[:warning] = "Invalid password or email!"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart_count] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to "/login"
  end
end
