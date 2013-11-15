#
# load any dependencies
#
require 'sinatra/base'
require 'sinatra/auth/github'

#
# load app
#
module FlailWeb
  class Hello < Sinatra::Base

    get '/' do 
      'Hello World!'
    end

  end
end
