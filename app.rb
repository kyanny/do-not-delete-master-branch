require 'sinatra'
require 'json'
require 'pp'
require 'net/https'
require 'uri'

helplers do
  def post_to_slack(ref: , repo_full_name: )
    uri = URI.parse(ENV.fetch("SLACK_INCOMING_WEBHOOK_URL"))
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    data = {
        text: "#{ref} branch of <https://github.com/#{repo_full_name}> is deleted. Please restore it! (<https://goo.gl/3MUqah|doc>)"
    }
    req.body = data.to_json
    https.request(req)
  end
end

get '/' do
  'ok'
end

post '/' do
  if params['q'] == ENV['BACKDOOR_KEY']
    post_to_slack(ref: 'test', repo_full_name: 'kyanny/test')
  else
    payload = JSON.parse(request.body.read)
    if payload['ref_type'] == 'branch' && payload['ref'] == 'master'
      post_to_slack(ref: payload['ref'], repo_full_name: payload['repository']['full_name'])
    end
  end
  'ok'
end
