module FlailWeb
  class App < Sinatra::Base
  
    get '/' do
      #authenticate_shim!
      @collection = FlailException.within(204.hours.ago)
      haml :index
    end
    
  end
end

