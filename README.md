daddy
=====

* create new rails app

  $ rails new [app_name] -d mysql

* move into Rails.root

  $ cd [app_name]

* add daddy gem

  $ vi Gemfile

* start server and check welcome page

  $ rails s
  view http://localhost:3000 on browser
  
* create controller for home page

  $ rails g controller [home_page]

* map root path to home controller

  * edit routes.rb
  * remove index.html

* create database

  $ vi database.yml
  $ rake dad:create_databases

* create first model

  $ rake db:migrate
  $ rails g model [model_name]
  
* create controller for the model

  $ rails g controller [controller_name]
