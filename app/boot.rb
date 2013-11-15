#
# load any dependencies
#
require 'haml'

require 'sinatra/base'
require 'sinatra/auth/github'

#
# load app
#
module FlailWeb
  class Hello < Sinatra::Base

    get '/' do 
      haml :index
    end

  end
end
