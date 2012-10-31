class Admin::CommentsController < ApplicationController
	load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!

  def update
    @comment = Comment.find(params[:id])
    @comment.update_column(:situation, !@comment.situation)
    respond_with @comment
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	post = @comment.post
  	@comment.destroy
  	respond_with post, :location => "/admin/posts/#{post.id}#comments_for_post"
  end

end
