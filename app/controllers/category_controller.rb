class CategoryController < ApplicationController
  # Se obtienen todas las categorías existentes para realizar el filtrado
  def index
    @categories = Category.all
    render json: @categories
  end
end
