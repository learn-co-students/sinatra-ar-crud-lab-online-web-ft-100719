
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

  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article
      erb :show
    else
      redirect '/articles'
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.update(title: params[:title], content: params[:content])
    if @article.save
      erb :show
    else
      redirect '/articles'
    end
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.destroy
    erb :delete
  end


end
