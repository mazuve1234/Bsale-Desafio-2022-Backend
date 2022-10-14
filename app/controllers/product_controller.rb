class ProductController < ApplicationController
  def index
    @books = Product.find_by_sql('Select * from product')
  end

  def show
  end
end
