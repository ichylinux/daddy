daddy
=====

* create new rails app

  $ rails new [app_name] -d mysql

* move into Rails.root

  $ cd [app_name]

* edit Gemfile to add daddy

* start server and check welcome page

  $ rails s
  
* create controller for home page

  $ rails g controller [home_page_name]

* map root path to home controller

  * edit routes.rb
  * remove index.html

* create database

  $ rake dad:create_databases

* create first model

  $ rake db:migrate
  $ rails g model [model_name]
  
* create controller for the model

  $ rails g controller [controller_name]
