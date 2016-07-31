class ProductsController < ApplicationController
  def index
    @products = Product.all
    if params[:sort_a]
      @products = Product.order(params[:sort_a])
    end
    if params[:sort_d]
      @products = Product.order(params[:sort_d] => "desc")
    end
    if params[:sort_discount]
      @products = Product.where("#{params[:sort_discount]} < ?", 20)
    end
    #render "index.html.erb"
  end

  def show
    if params[:id] == "random"
      @product = Product.all.sample
    else
      @product = Product.find_by(id: params[:id])
    end
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      image: params[:image],
      description: params[:description]
    )
    @product.save
    redirect_to "/products/#{@product.id}"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render 'edit.html.erb'
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update(
      name: params[:name],
      price: params[:price],
      image: params[:image],
      description: params[:description]
    )
    flash[:success] = "#{@product.id} was successfully updated !!"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    flash[:success] = "#{product.id} was successfully deleted !!"
    redirect_to "/products"
  end

  def search
    @products = Product.where("name LIKE ?", "%#{params[:search]}%")
    render "index.html.erb"
  end

  def new_form
    render "new_form.html.erb"
  end

  def add_to_database
    Product.create(
      name: params[:name],
      price: params[:price],
      image: params[:image],
      description: params[:description]
    )
    render "new_form.html.erb"
  end
end
