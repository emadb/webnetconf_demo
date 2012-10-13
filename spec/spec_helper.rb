require File.join(File.dirname(__FILE__), '..', 'app/main.rb')
require File.join(File.dirname(__FILE__), '..', 'app/model.rb')


require 'sinatra'
require 'rack/test'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

configure do
  Mongoid.configure do |config|
    config.sessions = { 
      :default => {:hosts => ["localhost:27017"], :database => "webnetconf_test" }}
  end
end

def app
  TodoApiDemo
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end