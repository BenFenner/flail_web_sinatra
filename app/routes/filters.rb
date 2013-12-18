module FlailWeb
  class App < Sinatra::Base

    before '/filters' do
      @nav_location = 'filters'
    end
    
    before '/filters/*' do
      @nav_location = 'filters'
    end

    get '/filters' do
      @collection = Filter.all
      haml 'filters/index'.to_sym
    end
    
    get '/filters/:id' do
      @filter = Filter.find(params[:id])
      @filtered_exceptions = FlailException.digested(@filter.filtered_exceptions)
      haml 'filters/show'.to_sym
    end
    
    post '/filters/:id' do
      Filter.find(params[:id]).destroy!
      flash[:notice] = "Filter was successfully destroyed."
      redirect to('/filters')
    end

  end
end
