require 'rubygems'
require 'sinatra'
Bundler.require
require 'sinatra/reloader' if development?
require 'model'

before do
  content_type :json
end

get '/todos' do
	Todo.all.to_json
end

get '/todo/:id' do
  todo = Todo.find(params[:id])
  todo.to_json
end

post '/todo/' do
  todo = Todo.create!(params)
  status, body = 201, {:url => "/todo/#{todo._id}"}.to_json
end

