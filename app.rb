# Encoding: utf-8
require 'sinatra'
require 'json'
require 'yaml'



configure do
  list = YAML.load_file('./list.yml')
  set :server, :puma
end


list = YAML.load_file('./list.yml')


class App < Sinatra::Application
  list = YAML.load_file('./list.yml')


  get '/' do
    "Hello World!"
  end


  post '/incoming/' do
    File.write('./list.yml', list.to_yaml)
    list = YAML.load_file('./list.yml')
    params = {}
    intent = ""
    request.body.rewind
    request_payload = JSON.parse request.body.read #this is the input from the dilog flow app

    @params = request_payload['queryResult']['parameters']
    @intent = request_payload['queryResult']['intent']['displayName']

    puts @params #print the paramaters to the console
    #list[@params["items".downcase]] = @params["status"].downcase #save the data from dialog flow to your yaml file
    response = {'fulfillmentText' => 'What the web hook returns'}.to_json #return a result

  end
end
