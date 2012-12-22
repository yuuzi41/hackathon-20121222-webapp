require 'rubygems'
require 'sinatra'
require 'erb'

require 'pg'

get '/' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, count integer, create_at timestamp, modified_at timestamp)')

	sqlret = conn.exec('select title,url,count from mark_log order by count desc')
	@result = sqlret
	##
	erb :index
end

get '/api/add' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, count integer, create_at timestamp, modified_at timestamp)')

	##
	url = params['url']
	title = params['title']

	sqlret = conn.exec("select count(*) from mark_log where url = '#{url}'")

	if sqlret[0]['count'].to_i > 0
		conn.exec("update mark_log set title = '#{title}',count = count+1, modified_at = CURRENT_TIMESTAMP where url = '#{url}'")
	else
		conn.exec("insert into mark_log (title,url,count,create_at,modified_at) values ('#{title}', '#{url}', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
	end

	"{'status': 'ok'}"
end

get '/api/cnt' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('create table if not exists mark_log (id serial, title text, url text, count integer, create_at timestamp, modified_at timestamp)')

	##
	url = params['url']
	sqlret = conn.exec("select count from mark_log where url = '#{url}'")

	if sqlret.count > 0
		return "{'count': #{sqlret[0]['count']}}"
	else
		return "{'count': 0}"
	end
end

get '/api/__clear' do
	conn = PGconn.connect('ec2-54-243-248-219.compute-1.amazonaws.com',	5432, '','','d8stnhug3r00sl','sqykholuteropu','Z8pzL6QAtHO4n37cFtKoMZc9CS')
	conn.exec('drop table if exists mark_log')

	"{'status': 'ok'}"
end
