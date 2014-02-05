module FlailWeb
  class App < Sinatra::Base
  
    before '/web_hooks' do
      authenticate!
      @nav_location = 'web_hooks'
    end
    
    before '/web_hooks/*' do
      authenticate!
      @nav_location = 'web_hooks'
    end
  
    get '/web_hooks' do
      haml 'web_hooks/index'.to_sym
    end
    
    post '/web_hooks' do
      web_hook_attrs = params[:web_hook]
      WebHook.create({:secure => web_hook_attrs[:secure], :url => web_hook_attrs[:url], :event => web_hook_attrs[:event]})
      flash[:notice] = "Web hook was successfully created."
      redirect to('/web_hooks')
    end
    
    get '/web_hooks/new' do
      haml 'web_hooks/new'.to_sym
    end
    
    delete '/web_hooks/:id' do
      WebHook.find(params[:id]).destroy!
      flash[:notice] = "Web hook was successfully destroyed."
      redirect to('/web_hooks')
    end

  end
end
