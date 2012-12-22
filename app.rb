require 'rubygems'
require 'sinatra'

get '/' do
	'Hello, world.'
end

get '/api/add' do
	url = params['url']
end
