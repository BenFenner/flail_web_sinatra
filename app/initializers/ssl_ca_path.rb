# monkey patch net:http to always use a default ca_path
require 'net/https'
class Net::HTTP
  alias orig_initialize initialize
  def initialize(*args, &blk)
    orig_initialize(*args, &blk)

    self.ca_path = '/etc/ssl/certs'
  end
end
