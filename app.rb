require 'rubygems'
require 'sinatra'
Bundler.require
require 'sinatra/reloader' if development?
require 'model'


get '/' do
	"Hello world!!"
	 u = User.new
	 u.name = 'ema'
	 u.age = 38
	 u.save
end