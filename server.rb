require 'pry'
require 'sinatra'
require 'csv'

## get movie data ##

def csv_import(filename)
  results = []
  CSV.foreach(filename, headers: true,header_converters: :symbol ) do |row|
    results << row.to_hash
  end
  results
end


## set routes ##

get '/' do
  @movie_data = csv_import('movies.csv')

  erb :movies
end


