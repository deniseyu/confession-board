require 'sinatra/base'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/confession_board_#{env}")

require './lib/confession'

DataMapper.finalize
DataMapper.auto_upgrade!

class ConfessionBoard < Sinatra::Base
  set :public_folder, 'public'

  get '/' do
    @confessions = Confession.all
    erb :index
  end

  post '/confess' do 
    content = params["content"]
    Confession.create(:content => content)
    redirect to '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
