#coding : utf-8
class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params[:comment])
		flash[:warning] = 'Comentário enviado para aprovação' if @comment.save
		respond_with @comment.post
	end

end