require 'rubygems'
require 'sinatra'
Bundler.require
require 'sinatra/reloader' if development?
require 'model'


get '/' do
	Todo.all.to_json
end