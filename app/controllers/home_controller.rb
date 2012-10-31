class HomeController < ApplicationController

  def index
    @posts = Post.search_in_blog(params)
    respond_with @posts
  end


end

