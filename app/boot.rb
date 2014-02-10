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
require_relative 'database_config'


# Setup Github/Octokit environment variables.
require_relative 'github_auth_config'


# Configure Octokit for Github OAuth.
Octokit.configure do |c|
  c.api_endpoint = ENV['OCTOKIT_API_ENDPOINT']
  c.web_endpoint = ENV['OCTOKIT_WEB_ENDPOINT']
end


# Load app.
require_relative 'initializers/ssl_ca_path'
require_relative 'app'
