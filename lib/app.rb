require 'sinatra'
require 'json'

set :bind, '0.0.0.0'
set :port, 4567

get '/run_script' do
  output = `ruby dos_titulos/main.rb`
  { output: output }.to_json
end
