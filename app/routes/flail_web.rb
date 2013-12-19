module FlailWeb
  class App < Sinatra::Base
  
    get '/' do
      #authenticate_shim!
      @collection = FlailException.within(25.days.ago).unresolved
      @collection = @collection.tagged(params[:tagged]) unless params[:tagged].blank?
      haml :index
    end
    
    post '/' do
      fe = FlailException.swing!(params)
      filtered = fe.check_against_filters!(Filter.all)
      WebHook.trigger(:exception, fe, url("digests/#{fe.digest}")) unless filtered
    end
    
  end
end

