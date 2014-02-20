module FlailWeb
  class App < Sinatra::Base

    get '/' do
      authenticate!
      @collection = FlailException.within(24.hours.ago).unresolved
      @collection = @collection.tagged(params[:tagged]) unless params[:tagged].blank?
      haml :index
    end

    post '/swing' do
      json_params = JSON.parse(request.body.read)
      fe = FlailException.swing!(json_params)
      filtered = fe.check_against_filters!(Filter.all)
      WebHook.trigger(:exception, fe, url("digests/#{fe.digest}")) unless filtered
    end

    get '/logout' do
      logout!
      
      # If logout works, this error will never show and the user will be
      # redirected to the Github login page. If the logout fails (because
      # the user is still authenticated with Github), they will be redirected
      # to the Flail Web home page and given the explanatory error notice.
      flash[:error] = "Logging out failed! Flail uses GitHub for user authentication. Please log 
                      out of any active GitHub sessions and then try logging out again. You may even 
                      have to actively visit and log out of GitHub before you can log out of Flail."
      redirect to('/')
    end

  end
end

