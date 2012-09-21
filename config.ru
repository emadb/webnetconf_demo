$LOAD_PATH << File.dirname(__FILE__)
require 'app'

configure do
	Mongoid.configure do |config|
    config.sessions = { 
			:default => {:hosts => ["localhost:27017"], :database => "webnetconf" }}
  end
end


run Sinatra::Application