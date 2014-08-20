require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'csv'

## get movie data ##

def csv_import(filename)
  results = []
  CSV.foreach(filename, headers: true,header_converters: :symbol ) do |row|
    results << row.to_hash
  end
  results
end

def sort_data(movie_array)
  movie_array.sort_by do |movie|
    movie[:title]
  end
end

sorted_data = sort_data(csv_import('movies.csv'))


## set routes ##

get '/' do
  @movie_data = sorted_data
  erb :movies
end

get '/movies' do
  @movie_data = sorted_data
  erb :movies
end

get '/movie/:id' do
  @movie_data = sorted_data
  @movie_title = sorted_data.select { |movie| movie[:id] == params[:id]}
  erb :title_page
end

