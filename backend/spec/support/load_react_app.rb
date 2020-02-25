require 'bundler/setup'
require 'sinatra'

set :public_folder, 'client/'

get '/' do
  erb :react_app
end