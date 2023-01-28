require 'sinatra'
require 'json'

get '/run_script' do
  output = `ruby dos_titulos/main.rb`
  { output: output }.to_json
end
