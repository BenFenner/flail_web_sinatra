module FlailWeb
  class App < Sinatra::Base
  
    get '/' do
      #authenticate_shim!
      @collection = FlailException.within(15.days.ago)
      haml :index
    end
    
  end
end

