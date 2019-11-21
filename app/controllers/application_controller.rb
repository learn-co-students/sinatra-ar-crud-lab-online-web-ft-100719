
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do
    #extract data from params
    @article = Article.new
    @article.title = params[:title]
    @article.content = params[:content]
    if @article.save
      redirect "/articles/#{@article.id}"
    else
      redirect "articles/new"
    end
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    if @article
      erb :show
    else
      redirect '/articles'
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    if @article
      erb :edit
    else
     redirect '/articles'
    end
  end

  patch '/articles/:id' do
    
    @article = Article.find_by(id: params[:id])
    if @article.update(title:params[:title], content: params[:content])
      redirect "/articles/#{@article.id}"
    else
      redirect "/articles/#{@article.id}/edit"
    end
  end

  delete '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.delete
    redirect "/articles"
  end

end
