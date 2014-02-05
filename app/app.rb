module FlailWeb
  class App < Sinatra::Base

    # Set up anything our routes need later.
    enable :sessions
    use Rack::Flash
    use Rack::MethodOverride
    helpers Sinatra::FormHelpers

    # Configure Github authorization.
    set :github_options, {

      # No scope given, which currently limits permissions to the user's Github account to read-only.
      # We should have no need to write to the user's Github account.
      :scopes => '',

      :client_id => ENV['GITHUB_CLIENT_ID'],
      :secret => ENV['GITHUB_CLIENT_SECRET'],
      :callback_url => ENV['GITHUB_CLIENT_CALLBACK'],
    }
    register Sinatra::Auth::Github

    # Less @import statements only work for css file extensions without this.
    Less.paths << File.join(settings.views, 'less')

    # A specialized route to handle stylesheet (less and css) stuff.
    get '/application.stylesheet' do
      less '/less/application'.to_sym
    end

  end 
end

# Add new route files here. (Order dependent.)
require_relative 'routes/flail_web'
require_relative 'routes/digests'
require_relative 'routes/filters'
require_relative 'routes/web_hooks'

