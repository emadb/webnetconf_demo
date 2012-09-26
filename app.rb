require 'sinatra'
require 'sinatra/reloader' if development?
require './config'
require './model'

before do
  content_type :json
  #puts request.accept
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

delete '/todo/:id' do
  todo = Todo.find(params[:id])
  todo.delete
  status, body = 204
end

put '/todo/:id' do
  puts params.to_json
  todo = Todo.find(params[:id])
  todo.update_attributes(description: params[:description], due_date: params[:due_date])
  status, body = 201, {:url => "/todo/#{todo._id}"}.to_json
end


