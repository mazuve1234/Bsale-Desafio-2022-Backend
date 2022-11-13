Rails.application.routes.draw do
  # Rutas para los controladores de category y product
  get 'category/index'
  get 'product/search', to: 'product#search'
end
