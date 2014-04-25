module FlailWeb
  class App < Sinatra::Base

    get '/' do
      authenticate_shim!
      @collection = FlailException.unresolved
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

    get '/chart_data.json' do
      authenticate_shim!
      content_type :json

      data = []

      # Gather the number of exeptions from the last 24 hours in one-hour chunks to be used in the bar chart.
      (0..23).to_a.reverse.map do |index|
        time = Time.now.change(min: 0) - index.hours
        exceptions = FlailException.select("created_at").within(time, time + 1.hour).take(100)
        exceptions = exceptions.tagged(params[:tagged]) unless params[:tagged].blank?
        num_exceptions = exceptions.size
        hour_text = time.strftime("%l%p")
        if hour_text == "12AM" then hour_text = "\u263D" end # First quarter moon character
        if hour_text == "12PM" then hour_text = "\u263C" end # White sun with rays character
        data << { hour: hour_text, exceptions: num_exceptions }
      end

      data.to_json
    end

  end
end

