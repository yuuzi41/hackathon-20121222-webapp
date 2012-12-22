require 'rubygems'
require 'sinatra'

require 'pg'

get '/' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, create_at timestamp)')

	##
	'Hello, world.'
end

get '/api/add' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, create_at timestamp)')

	##
	url = params['url']
	title = params['title']

	conn.exec("insert into mark_log (title,url,create_at) values ('#{url}', '#{title}', CURRENT_TIMESTAMP)")
	"{'status': 'ok'}"
end

get '/api/cnt' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, create_at timestamp)')

	##
	url = params['url']
	sqlret = conn.exec("select count(*) from mark_log where url = '#{url}'")

	"{'count': #{sqlret[0]['count']}}"
end

get '/api/__clear' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('drop table if exists mark_log')

	"{'status': 'ok'}"
end
