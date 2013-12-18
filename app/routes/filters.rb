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
      filter = Filter.find(params[:id])
      filter.update_attributes(params[:filter])
      flash[:notice] = "Filter was successfully updated."
      redirect to("/filters/#{params[:id]}")
    end
    
    delete '/filters/:id' do
      Filter.find(params[:id]).destroy!
      flash[:notice] = "Filter was successfully destroyed."
      redirect to('/filters')
    end
    
    get '/filters/:id/edit' do
      @filter = Filter.find(params[:id])
      haml 'filters/edit'.to_sym
    end

  end
end
