require 'sinatra/base'
require 'data_mapper'
require 'sinatra/flash'
require 'byebug'

require './app/data_mapper_setup.rb'

class TechmarkManager < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }

  enable :sessions, :static
  set :session_secret, 'super-secret'
  register Sinatra::Flash
  use Rack::MethodOverride

  get '/' do
    @user = User.new
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :'links/links'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title], description: params[:description].capitalize)


    multi_category = params[:category].split
    multi_category_count = multi_category.count

    multi_category_count.times do
      category = Category.new
      category.name = multi_category.shift.capitalize
      category.save
      link.categories << category
    end

    link.save
    redirect to('/links')
  end

  get '/links/:name' do
    category = Category.first(name: params[:name].capitalize)
    @links = category ? category.links : []
    erb :'links/links'

  end

  # get  '/user/new' do
  #   @user = User.new
  #   erb :'user/new'
  # end

  post '/user' do
    @user = User.new(first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email],
                    username: params[:username],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation]
                    )
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'user/new'
    end
  end

  # get '/session/new' do
  #   erb :'user/sign_in'
  # end

  post '/session' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect to '/links'
    else
      flash.now[:errors] = ['The username or password is incorrect']
      erb :'user/sign_in'
    end
  end

  delete '/session' do
    session.clear
    flash[:notice] = 'Goodbye'
    redirect '/'
  end

  helpers do

    def current_user
      user ||= User.get(session[:user_id])
    end

  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
