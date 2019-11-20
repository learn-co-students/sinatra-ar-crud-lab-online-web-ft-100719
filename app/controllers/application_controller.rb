require_relative '../../config/environment'
require 'pry'
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
    @articles = Article.all

    erb :index
  end

  post '/articles' do
    Article.create(title: params[:title], content: params[:content])
    id = Article.last.id
    redirect "/articles/#{id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])

    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])

    redirect '/articles'
  end
end
