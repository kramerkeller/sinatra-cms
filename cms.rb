# cms.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'super secret'
end

def file_names
  Dir['files/*'].map { |name| name.gsub("files/", "") }
end

get '/' do
  @file_names = file_names

  erb :files
end

get '/:filename' do
  file_name = params[:filename]
  error = !file_names.include?(file_name)

  if error
    session[:error] = "#{file_name} does not exist"
    redirect '/'
  else
    file_path = "files/#{file_name}"
    headers["Content-Type"] = "text/plain"
    File.read(file_path)
  end
end
