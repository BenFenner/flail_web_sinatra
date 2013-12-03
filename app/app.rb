module FlailWeb
  class App < Sinatra::Base
    #
    # set up anything our routes need later
    #
    enable :sessions
    use Rack::Flash

  end 
end

# add new route files here
require_relative 'routes/flail_web'

