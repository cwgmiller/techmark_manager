require 'sinatra/base'
require './app/data_mapper_setup'
require 'data_mapper'

class TechmarkManager < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    'Hello TechmarkManager!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/links'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links/new' do
    link = Link.create(url: params[:url], title: params[:title], description: params[:description])
    link.category << Category.create(name: params[:category])
    link.save
  redirect to('/links')
  end

  get '/links/:name' do
    category = Category.first(name: params[:name])
    @links = category ? category.links : []
    erb :'links/links'
  end




  # start the server if ruby file executed directly
  run! if app_file == $0
end
