module FlailWeb
  class App < Sinatra::Base
    get '/' do
      #authenticate_shim!
      haml :index
    end
  end
end
