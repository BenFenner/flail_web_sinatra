require File.expand_path(File.dirname(__FILE__) + '/app/boot')

map '/flail' do
  run FlailWeb::App
end

