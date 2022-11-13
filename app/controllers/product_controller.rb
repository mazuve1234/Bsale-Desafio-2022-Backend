class ProductController < ApplicationController
  # Funcionalidad de search implementada en el servidor para obtener solo los productos deseados
  def search
    @results = if params[:query]
                 Product.where('lower(name) LIKE ?', '%' + params[:query].downcase + '%')
               else
                 Product.all
               end
    render json: @results
  end

end
