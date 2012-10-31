class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.actived?.paginate(:page => params[:page], :per_page => 5).order(:id => :desc)
    @total_comments = @post.comments.actived?.size
    @assets = @post.archives
    @comment = @post.comments.build
    respond_with @post
  end

  
end
