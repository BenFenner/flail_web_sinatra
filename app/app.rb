module FlailWeb
  class App < Sinatra::Base

    # set up anything our routes need later
    enable :sessions
    use Rack::Flash
    
    # Less @import statements only work for css file extensions without this
    Less.paths << File.join(settings.views, 'less')

    # A specialized route to handle stylesheet (less and css) stuff
    get '/application.stylesheet' do
      less '/less/application'.to_sym
    end

  end 
end

# add new route files here
require_relative 'routes/flail_web'
require_relative 'routes/digests'
require_relative 'routes/filters'
require_relative 'routes/web_hooks'

