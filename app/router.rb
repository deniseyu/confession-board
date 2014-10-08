require 'sinatra/base'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/confession_board_#{env}")

require './lib/confession'

DataMapper.finalize
DataMapper.auto_upgrade!

class ConfessionBoard < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/' do

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
