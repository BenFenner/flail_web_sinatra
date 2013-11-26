module FlailWeb
  class App < Sinatra::Base
    #
    # set up anything our routes need later
    #
    enable :sessions
    use Rack::Flash
    
    # custom view path, sinatra defaults this to be the root dir + '/views'
    #set :views, Proc.new { File.join(root, '../app/views') }

    module ClassMethods
      #def root
        #@root ||= File.expand_path(File.dirname(__FILE__) + '/..')
      #end
    end
    extend ClassMethods
  end
end

# add new route files here
require_relative 'routes/flail_web'

