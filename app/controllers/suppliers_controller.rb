class SuppliersController < ApplicationController
  def new
    render "new.html.erb"
  end

  def create
    @supplier = Supplier.new(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      supplier_id: params[:supplier_id]
    )
    @supplier.save
    redirect_to "/suppliers/new"
  end

  def 
end
