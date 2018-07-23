# cms.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get '/' do
  @file_names = Dir['files/*'].map { |name| name.gsub("files/", "") }

  erb :files
end

get '/:filename' do
  file_path = "files/" + params[:filename]
  headers["Content-Type"] = "text/plain"
  File.read(file_path)
end
