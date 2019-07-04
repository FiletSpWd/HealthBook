# HealthBook

Hi! It's my college diploma project on Ruby on Rails. This web app developed for people who like to follow healthy-food principles (view fat, protein, sugar and calories). Users can create their own diet and recipes as well as share it with others :)

# Getting started

To get the Rails server running locally:

- Clone this repo
- `bundle install` to install all req'd dependencies
- `rake db:migrate` to make all database migrations
- `rails s` to start the local server

# About application

## Role
* newuser - simple user;
* editor - publish recipes, add category and advice;
* admin - has admin panel, address: `localhost:3000/a`.

## Authorized user can:
* add recipes
* add favorite recipes
* add comments for recipe
* get marks
* calculate balance calories of day
* add recipe to menu
* full-text search by titles
* sorting by fields

## Screenshot

![main page](https://pp.userapi.com/c858236/v858236440/9fa8/P6UIIpfouiA.jpg)
![user menu](https://pp.userapi.com/c858016/v858016440/a0ce/EW0jOKSFX-0.jpg)



# Configuration

* Ruby version - 2.6.1p33
* Ruby on Rails - 5.2.3
* Database - PostgreSQL

## Dependencies

- [bootstrap](https://github.com/twbs/bootstrap-rubygem) - For style
- [jquery-ui-rails](https://github.com/jquery-ui-rails/jquery-ui-rails) - For autocomplite
- [devise](https://github.com/plataformatec/devise) - For authentication
- [trix](https://github.com/kylefox/trix/) - For markdown
- [carrierwave](https://github.com/carrierwaveuploader/carrierwave) - For uploader photo
- [cancancan](https://github.com/CanCanCommunity/cancancan) - For role ability 
- [rolify](https://github.com/RolifyCommunity/rolify) - For role
- [rails_admin](https://github.com/sferik/rails_admin) - For admin panel
- [pg_search](https://github.com/Casecommons/pg_search) - For full-text search

## Folders

- `app/models` - Contains the database models for the application where we can define methods, validations, queries, and relations to other models.
- `app/views` - Contains templates for generating the JSON output for the API
- `app/controllers` - Contains the controllers where requests are routed to their actions, where we find and manipulate our models and return them for the views to render.
- `config` - Contains configuration files for our Rails application and for our database, along with an `initializers` folder for scripts that get run on boot.
- `db` - Contains the migrations needed to create our database schema.
