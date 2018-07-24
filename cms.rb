# cms.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"

configure do
  enable :sessions
  set :session_secret, 'super secret'
end

def path
  if ENV["RACK_ENV"] == "test"
    "files/test/"
  else
    "files/"
  end
end

def filenames
  Dir['files/*'].map { |name| name.gsub("files/", "") }
end

############## Routes ##################

get '/' do
  @filenames = filenames

  erb :files, layout: :layout
end

get '/:filename' do
  filename = params[:filename]
  error = !filenames.include?(filename)

  if error
    session[:error] = "#{filename} does not exist"
    redirect '/'
  end

  file_ext = filename.split(".").last
  file = File.read(path + filename)

  if file_ext == 'md'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    erb markdown.render(file)
  else
    headers["Content-Type"] = "text/plain"
    file
  end
end

get '/:filename/edit' do
  @filename = params[:filename]
  @contents = File.read(path + @filename)

  erb :edit_file
end

post '/:filename' do
  filename = params[:filename]
  content = params[:contents]

  File.write(path + filename, content)

  session[:success] = "#{filename} has been updated"
  redirect "/"
end
