class ProductsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show, :search]

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
    if params[:category]
      category = Category.find_by(name: params[:category])
      @products = category.products
    end
    render "index.html.erb"
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
    @product = Product.new
    render "new.html.erb"
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description]
    )
    if @product.save
      flash[:success] = "Product is created!"
      redirect_to "/products/#{@product.id}"
    else
      flash[:danger] = @product.errors.full_messages
      render "new.html.erb"
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update(
      name: params[:name],
      price: params[:price],
      description: params[:description]
    )
    if @product.valid?
      flash[:success] = "#{@product.id} was successfully updated !!"
      redirect_to "/products/#{@product.id}"
    else
      flash[:danger] = @product.errors.full_messages
      render "edit"
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    flash[:success] = "#{product.id} was successfully deleted !!"
    redirect_to "/products"
  end

  def search
    @products = Product.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
    render "index.html.erb"
  end
end
