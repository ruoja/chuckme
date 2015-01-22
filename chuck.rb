require 'sinatra'
require 'net/http'
require 'json'

get '/' do
	@joke = get_joke("http://api.icndb.com/jokes/random")
	erb :home
end

post '/' do
	if params[:name].empty?
		@joke = get_joke("http://api.icndb.com/jokes/random")
	else
		@joke = get_joke("http://api.icndb.com/jokes/random?firstName=#{params[:name]}&lastName=")
	end
	erb :home
end

not_found do
	halt 404, 'Chuck Norris refuses to show you the page you requested'
end

def get_joke(url)
	resp = Net::HTTP.get_response(URI.parse(url))
	resp_hash = JSON.parse(resp.body)
	resp_hash["value"]["joke"]
end