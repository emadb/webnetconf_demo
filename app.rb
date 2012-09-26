require 'sinatra'
require 'sinatra/reloader' if development?
require './config'
require './model'

def format(data)
  if content_type[0] == 'text/xml'
      data.to_xml
    else #application/json
      data.to_json
  end
end

before do
  content_type :json
  content_type request.accept unless request.accept == '*/*'
end

get '/todos' do
	format Todo.all
end

get '/todo/:id' do
  todo = Todo.find(params[:id])
  format todo
end

post '/todo/' do
  todo = Todo.create!(params)
  headers["Location"] = "/todo/#{todo._id}"
  status 201  
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
  headers["Location"] = "/todo/#{todo._id}"
  status 201
end


