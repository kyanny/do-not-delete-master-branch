require 'sinatra'
require 'json'
require 'pp'
require 'net/https'
require 'uri'

get '/' do
  'ok'
end

post '/' do
  payload = JSON.parse(request.body.read)
  if payload['ref_type'] == 'branch' && payload['ref'] == 'master'
    uri = URI.parse(ENV.fetch("SLACK_INCOMING_WEBHOOK_URL"))
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    data = {
        text: "#{payload['ref']} branch of <https://github.com/#{payload["repository"]["full_name"]}> is deleted. Please restore it!"
    }
    req.body = data.to_json
    https.request(req)
  end
  'ok'
end