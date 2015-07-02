require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'
set :database, "sqlite3:login.sqlite3"
enable :sessions
use Rack::Flash, :sweep => true

get '/' do
  @pastPost = Post.last(10)
  erb :home
end

get '/sign_up' do
  erb :sign_up
end

get '/profile' do
  @session=session[:user_id]
  @userprofile=Profile.where("user_id" => @session).first
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

post '/sign-in' do
  @user = User.where(name: params[:username]).first
  if @user.password==params[:password]
    session[:user_id]=@user.id
    flash[:notice] = "You are signed in."
    redirect '/'
  else
    flash[:alert] = "There was a problem signing you in."
    redirect '/'
  end
  puts session[:user_id]
end

post '/log-out' do
  session.clear
  redirect '/'
end

post '/submit-post' do
  if session[:user_id]
    @post=Post.new(params[:post])
    @post[:user_id]=session[:user_id]
    @post[:datetime]=Time.now
    @post.save
  else
    puts "not logged in"
  end
  redirect '/'
end

post '/update' do
  @session=session[:user_id]
  @userprofile=Profile.where("user_id" => @session).first
  erb :update
end

post '/edit' do
  @session=session[:user_id]
  @profile=Profile.where("user_id" => @session).first
  @profile.update_attributes(params[:profile])
  redirect '/profile'
end









