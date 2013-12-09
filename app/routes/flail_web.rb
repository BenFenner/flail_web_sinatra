module FlailWeb
  class App < Sinatra::Base
  
    get '/' do
      #authenticate_shim!
      @collection = FlailException.within(15.days.ago)
      @collection = @collection.tagged(params[:tagged]) unless params[:tagged].blank?
      haml :index
    end
    
  end
end

