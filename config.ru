root = ::File.dirname(__FILE__)
Dir["app/*.rb"].each { |file| require ::File.join( root, file ) }

configure do
  Mongoid.configure do |config|
    config.sessions = { 
      :default => {:hosts => ["localhost:27017"], :database => "webnetconf" }}
  end
end


run TodoApiDemo