module FlailWeb
  class App < Sinatra::Base
  
    get '/digests/:digest_id?:offset?' do
      params[:offset] ||= 0
      resource
      haml 'digests/show'.to_sym
    end
    
    def resource
      @resource ||= FlailException.with_digest(params[:digest_id]).order('created_at desc').offset(params[:offset].to_i).first
    end

  end
end

