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
    "test/files/"
  else
    "files/"
  end
end

def filenames
  Dir[path + '*'].map { |name| name.gsub(path, "") }
end

############## Routes ##################

get '/' do
  @filenames = filenames
  @username = session[:username] ||= false

  erb :files, layout: :layout
end

get "/users/signin" do
  erb :signin
end

post "/users/signin" do
  @username = params[:username]
  password = params[:password]

  if @username == 'admin' && password == 'secret'
    session[:username] = @username
    session[:success] = "Welcome #{@username}"
    redirect '/'
  else
    session[:error] = "Invalid credentials"
    status 422
    erb :signin
  end
end

post "/users/signout" do
  session.delete(:username)
  session[:success] = "You have been signed out."
  redirect "/"
end

# New file form
get '/new' do
  erb :new_file
end

# Create new file
post '/create' do
  filename = params[:filename]

  if filename.length == 0
    session[:error] = "Name must be 1 - 50 characters"
    status 422
    erb :new_file
  else
    file_path = path + filename
    File.write(file_path, "")
    session[:success] = "#{filename} has been created"
    redirect "/"
  end
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

# Form to update existing file
get '/:filename/edit' do
  @filename = params[:filename]
  @contents = File.read(path + @filename)

  erb :edit_file
end

# Update existing file
post '/:filename' do
  filename = params[:filename]
  content = params[:contents]

  File.write(path + filename, content)

  session[:success] = "#{filename} has been updated"
  redirect "/"
end

post "/:filename/delete" do
  filename = params[:filename]
  File.delete(path + filename)
  session[:success] = "#{filename} has been deleted"
  redirect "/"
end
