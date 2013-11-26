#
# load any dependencies
#
require 'haml'

require 'sinatra/base'
require 'sinatra/auth/github'

require 'rack-flash'

#
# load app
#
require_relative 'app'
