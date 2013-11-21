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
module FlailWeb
  class Hello < Sinatra::Base
  
    enable :sessions
    use Rack::Flash

    get '/' do 
      haml :index
    end

  end
end
