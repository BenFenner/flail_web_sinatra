module FlailWeb
  class App < Sinatra::Base
  
    get '/web_hooks' do
      haml 'web_hooks/index'.to_sym
    end

  end
end
