require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
enable :session, :method_override


  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/new' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/delete_:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  put '/bookmarks/delete_:id' do
    p params
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end



  run! if app_file == $0
end
