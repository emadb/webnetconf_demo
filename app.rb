require 'sinatra'
require 'sinatra/reloader' if development?
require './config'
require './model'

helpers do
  def serialize(data)
    if content_type[0] == 'text/xml'
        data.to_xml
      else
        data.to_json
    end
  end

  def validate_key (key)
    error 401 unless key == 'rubyrocks'
  end
end

types = {:json => 'application/json', :xml => 'text/xml'}

before do
  #set content type
  content_type types[:json]
  content_type types[:xml] unless request.accept.include? types[:xml]
 
  # validate request token
  validate_key env['HTTP_WEBNET_AUTH_KEY']
end

get '/todos' do
	serialize Todo.all
end

get '/todo/:id' do
  todo = Todo.find(params[:id])
  #format todo
  serialize todo
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
  todo = Todo.find(params[:id])
  todo.update_attributes(description: params[:description], due_date: params[:due_date], completed?: params[:completed?])
  headers["Location"] = "/todo/#{todo._id}"
  status 201
end


