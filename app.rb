require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'
set :database, "sqlite3:login.sqlite3"
enable :sessions
use Rack::Flash, :sweep => true

get '/' do
  erb :home
end