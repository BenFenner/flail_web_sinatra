#
# load external dependencies
#
require 'haml'

require 'less'

require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/auth/github'

require 'rack-flash'

#
# load internal dependencies
#
require_relative 'models/flail_exception'
require_relative 'models/request_parameters'
require_relative 'models/filter'
require_relative 'helpers/application_helper'



#
# setup database connection
#

db = URI.parse('postgres://bfenner:test@localhost/flail_web_development')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)


#
# load app
#
require_relative 'app'
