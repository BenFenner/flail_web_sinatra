module FlailWeb
  class App < Sinatra::Base

    get '/digests/:digest_id?:offset?' do
      authenticate_shim!
      params[:offset] ||= 0
      resource
      haml 'digests/show'.to_sym
    end

    post '/digests/:digest_id?:offset?' do
      authenticate_shim!
      resource.resolve!
      WebHook.trigger(:resolution, resource, url("digests/#{resource.digest}"))
      flash[:notice] = "Resolved #{resource.occurrences.count} flailing exceptions: #{resource.class_name}"
      redirect to('/')
    end

    def resource
      @resource ||= FlailException.with_digest(params[:digest_id]).order('created_at desc').offset(params[:offset].to_i).first
    end

  end
end

