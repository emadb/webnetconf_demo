require "sinatra"

use Rack::Auth::Basic, "Private area" do |usr, pwd|
  [usr, pwd] == ['admin', 'admin']
end

get '/' do
  content_type :txt
  "hello" 
end