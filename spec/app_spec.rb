require 'spec_helper'

describe "Webnetconf App" do

  it "should respond with 401 if no credentials are set" do
    get '/todos'
    last_response.status.should be(401)
  end

  it "should respond with 401 if credentials are wrong" do
    get '/todos', nil, {"HTTP_WEBNET_AUTH_KEY" => 'csharprocks'}
    last_response.status.should be(401)
  end

  it "should respond with ok if credentials are right" do
    get '/todos', nil, {"HTTP_WEBNET_AUTH_KEY" => 'rubyrocks'}
    last_response.should be_ok
  end

  it "should create a new todo" do
    post '/todos', {:description => 'test to do', :due_date => '10/12/2012'}, {"HTTP_WEBNET_AUTH_KEY" => 'rubyrocks'}
    last_response.status.should be(201)
  end

end