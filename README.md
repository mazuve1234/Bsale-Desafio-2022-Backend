# Bsale-Desafio-2022-Backend

### Install MySQL
First, the user has to install the MySQL client with these commands.
```bash
  $ sudo apt-get update
  $ sudo apt-get install mysql-client libmysqlclient-dev
```

### Create Rails App
Use this command to create a new Rails app utilizing the MySQL client
```bash
  $ rails new [application name] -d mysql
```

### Connect to the remote MySQL database
Go to `config/database.yml` to fill in with the credentials given (username, password and host) to access the database bsale_test.
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
```

### Configure the table names
Since the table names are in singular, you need to insert this command in `config/enviroments/development.rb` so Rails can detect the table names and the GET operations get done correctly in the controllers.
```bash
  ActiveRecord::Base.pluralize_table_names = false
```

### Generate the controllers
For this exercise, only the index route will be necessary, being able to GET all the data required from the "product" and "category" tables.
```bash
  $ rails g controller product index
  $ rails g controller category index
```

### Render the data to JSON
In the index methods of both controllers, insert this code to render to JSON the data for the Front-end.
```bash
class ProductController < ApplicationController
  def index
    @products = Product.all
    render json: @products
  end
end
```

### Start the server
Type the following to open up the puma server with the base_uri: "http://127.0.0.1:3000". 
```bash
$ rails s
```

### Fix the CORS issue
Browsers usually block cross-origin requests so certain steps are required to bypass it.
First, install the required Gemfile.
```bash
gem 'rack-cors'
```
Then, go to `config/initializers/cors.rb` and insert this code.
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
For more info on CORS, check: https://medium.com/ruby-daily/understanding-cors-when-using-ruby-on-rails-as-an-api-f086dc6ffc41





  

