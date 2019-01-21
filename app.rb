require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get('/') do
  @recipes = cookbook.all
  erb :index
end


# get '/foods' do
#   @foods = %w(pizza burger salad noodles soup toast spaghetti)
#   erb :foods
# end

get('/new') do
  erb :new
end

post('/recipes') do
  name = params['name']
  description = params['description']
  new_recipe = Recipe.new(name, description)
  cookbook.add(new_recipe)
  redirect "/"
end

get '/delete/:index' do
  recipe_index = params["index"].to_i
  cookbook.remove_at(recipe_index)
  redirect '/'
end