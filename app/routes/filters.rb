module FlailWeb
  class App < Sinatra::Base
  
    get '/filters' do
      @collection = Filter.all
      haml 'filters/index'.to_sym
    end
    
    get '/filters/:id' do
      @filter = Filter.find(params[:id])
      @filtered_exceptions = FlailException.digested(@filter.filtered_exceptions)
      haml 'filters/show'.to_sym
    end

  end
end
