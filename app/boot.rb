# Load external dependencies.
require 'haml'

require 'json'

require 'less'

require 'octokit'

require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/auth/github'
require 'sinatra/form_helpers'

require 'rack-flash'


# Load internal dependencies.
require_relative 'models/flail_exception'
require_relative 'models/request_parameters'
require_relative 'models/filter'
require_relative 'models/web_hook'
require_relative 'helpers/application_helper'


# Setup database connection.
db = URI.parse('postgres://bfenner:test@localhost/flail_web_development')
ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)


# Setup Github/Octokit environment variables.
ENV['OCTOKIT_API_ENDPOINT'] = 'https://example.com/api/v3'
ENV['OCTOKIT_WEB_ENDPOINT'] = 'https://example.com/'
ENV['GITHUB_OAUTH_DOMAIN'] = 'https://example.com'
ENV['GITHUB_CLIENT_ID'] = 'example'
ENV['GITHUB_CLIENT_SECRET'] = 'example'
ENV['GITHUB_CLIENT_CALLBACK'] = 'http://example.com/flail'


# Configure Octokit for Github OAuth.
Octokit.configure do |c|
  c.api_endpoint = ENV['OCTOKIT_API_ENDPOINT']
  c.web_endpoint = ENV['OCTOKIT_WEB_ENDPOINT']
end


# Load app.
require_relative 'initializers/ssl_ca_path'
require_relative 'app'
