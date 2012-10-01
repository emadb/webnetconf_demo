require 'sinatra'

before do 
  content_type :txt
end

connections = []
get '/listen' do 
  stream :keep_open do |out|
    connections << out
  end 
end

get '/send/:message' do 
  connections.each do |out|
    out << "#{Time.now} -> #{params[:message]}" << "\n" 
  end
  "Sent #{params[:message]} to all clients." 
end