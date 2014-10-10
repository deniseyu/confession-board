require 'sinatra/base'
require 'data_mapper'
require 'dm-core'
require 'dm-migrations'
require './lib/confession'
require './secret.rb'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/confession_board_#{env}")
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

  get '/upvote/:id' do 
    confession = Confession.first(:id => params[:id])
    confession.upvote
    redirect '/'
  end

  get '/downvote/:id' do 
    confession = Confession.first(:id => params[:id])
    confession.downvote
    redirect '/'
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

  helpers do
      include Rack::Utils
      alias_method :h, :escape_html
  end


end 