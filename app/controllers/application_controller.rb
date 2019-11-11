
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @article = Article.all
    erb :index
  end

  post '/articles' do
    @article = Article.create(params[:article])
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end 

  patch '/articles/:id' do
    
    id = params["id"]
    new_params = {}
    old_article = Article.find_by(id: params[:id])
    new_params[:title] = params["title"]
    new_params[:content] = params["content"]
    old_article.update(new_params)

    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    #binding.pry
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect :index
  end

end
  
