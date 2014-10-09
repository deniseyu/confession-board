require 'sinatra/base'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/confession_board_#{env}")

require './lib/confession'
require './app/secret.rb'

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

  get '/supersecretadmin' do 
    protected!
    @confessions = Confession.all 
    erb :admin
  end

  post '/supersecretadmin' do
    delete_id = params["delete_id"]
    item = Confession.first(:id => delete_id)
    item.destroy
    redirect '/supersecretadmin'
  end

  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials == ['admin', $SUPER_SECRET_PASSWORD]
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
