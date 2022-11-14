# Bsale-Desafio-2022-Backend

Esta aplicación fue diseñada utilizando el framework Ruby on Rails y la base de datos MySQL. Sirve como un API que brinda el método de petición HTTP GET del contenido de su base de datos para ser extraída en la visualización de una página web.

### Instalar MySQ
Primero, el usuario tiene que instalar el cliente MySQL con estos comandos.
```bash
  $ sudo apt-get update
  $ sudo apt-get install mysql-client libmysqlclient-dev
```

### Crear aplicación de Rails
Use este comando para crear una nueva aplicación Rails utilizando el cliente MySQL
```bash
  $ rails new [application name] -d mysql
```

### Conéctese a la base de datos MySQL remota
Vaya a `config/database.yml` para completar con las credenciales proporcionadas (nombre de usuario, contraseña y host) para acceder a la base de datos bsale_test.
```bash
  default: &default
    adapter: mysql2
    encoding: utf8mb4
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    username: [username]
    password: [password]
    host: [host]

  development:
    <<: *default
    database: bsale_test
   
   production:
    <<: *default
    database: bsale_test
    username: [username]
    password: [password]
```

### Configurar los nombres de las tablas
Dado que los nombres de las tablas están en singular, debe insertar este comando en `config/enviroments/development.rb` para que Rails pueda detectar los nombres de las tablas y las operaciones GET se realicen correctamente en los controladores.
```bash
  ActiveRecord::Base.pluralize_table_names = false
```
### Generar los modelos
Solo se generarán los modelos pero no se ejecutarán las migraciones. El propósito de esto es crear los modelos para las dos tablas para que los datos puedan recuperarse más tarde.
```bash
  $ rails g model Product name url_image price:float discount:integer
  $ rails g model Category name
```


### Generar los controladores
Para este ejercicio solo será necesaria la rutas "search" para los productos e "index" para las categorías, pudiendo OBTENER todos los datos requeridos de las tablas de "producto" y "categoría".
```bash
  $ rails g controller product search
  $ rails g controller category index
```

### Renderizar los datos a JSON
En los métodos de ambos controladores, inserte este código para representar en JSON los datos para el Front-end.
#### Product.all: Muestra todo los elementos presentes en la base de datos.
#### Product.where('lower(name) LIKE ?'): Muestra los elementos presentes en la base de datos que cumplan con la condición del nombre del producto por medio del patrón envíado como parametro en la URL.
```bash
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

class CategoryController < ApplicationController
  # Se obtienen todas las categorías existentes para realizar el filtrado en el front-end.
  def index
    @categories = Category.all
    render json: @categories
  end
end
```
### Verificar las rutas
Las rutas servirán para que la aplicación de front-end pueda extraer los datos del servidor.
```bash
Rails.application.routes.draw do
  # Rutas para los controladores de category y product
  get 'category/index'
  get 'product/search', to: 'product#search'
end
```
![image](https://user-images.githubusercontent.com/104693521/201513813-c5205297-37bb-433f-8712-611c1c0d851e.png)
![image](https://user-images.githubusercontent.com/104693521/201513792-878a2d41-e7fa-4b4f-ae70-731c85ceffd7.png)


### Iniciar el servidor
Escriba lo siguiente para abrir el servidor puma con el base_uri: "http://127.0.0.1:3000".
```bash
$ rails s
```

### Solucionar el problema de CORS
Los navegadores generalmente bloquean las solicitudes de origen cruzado, por lo que se requieren ciertos pasos para evitarlo.
Primero, instale el Gemfile requerido.
```bash
gem 'rack-cors'
```
Luego, vaya a `config/initializers/cors.rb` e inserte este código.
```bash
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```
Para obtener más información sobre CORS, consulte: https://medium.com/ruby-daily/understanding-cors-when-using-ruby-on-rails-as-an-api-f086dc6ffc41

### Implementar la API
Con estos comandos, la API se implementará en Heroku y se otorgará un nuevo host: "https://shielded-garden-61293.herokuapp.com/"
```bash
$ heroku create
$ git push heroku main
```





  

