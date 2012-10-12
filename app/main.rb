require 'rubygems'
Bundler.require
require 'sinatra/reloader' if development?

class TodoApiDemo < Sinatra::Base

  helpers do
    CONTENT_TYPES = {:json => 'application/json', :xml => 'text/xml'}

    def serialize (data)
      if content_type.include? CONTENT_TYPES[:xml]
          data.to_xml
        else
          data.to_json
      end
    end

    def validate_key (key)
      error 401 unless key == 'rubyrocks'
    end
  end


  before do
    #set content type
    content_type CONTENT_TYPES[:json]
    content_type CONTENT_TYPES[:xml] if request.accept.include? CONTENT_TYPES[:xml]

    # validate request token
    validate_key env['HTTP_WEBNET_AUTH_KEY']
  end

  get '/todos' do
    #expires 60, :public, :must_revalidate
  	serialize Todo.all
  end

  get '/todos/:id' do
    todo = Todo.find(params[:id])
    serialize todo
  end

  post '/todos' do
    todo = Todo.create!(params)
    headers["Location"] = "/todo/#{todo._id}"
    status 201  
  end

  delete '/todos/:id' do
    todo = Todo.find(params[:id])
    todo.delete
    status 204
  end

  put '/todos/:id' do
    todo = Todo.find(params[:id])
    todo.update_attributes(:description => params[:description], :due_date => params[:due_date], :completed? => params[:completed])
    headers["Location"] = "/todo/#{todo._id}"
    status 201
  end

end

