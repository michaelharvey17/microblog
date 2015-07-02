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

get '/sign_up' do
  erb :sign_up
end

get '/profile' do
  erb :profile
end

post '/signup' do
  @user=User.create(params[:user])
  @profile=Profile.new(params[:profile])
  @profile[:user_id]=@user.id
  @profile[:datetime]=Time.now
  @profile.save
  session[:user_id]=@user.id
  redirect '/'
end