# cms.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"

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
  end

  file_ext = file_name.split(".").last
  file = File.read("files/#{file_name}")

  if file_ext == 'md'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(file)
  else
    headers["Content-Type"] = "text/plain"
    file
  end
end
