class Admin::PostsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :atualizar_situation, :only => :index
  before_filter :load_resources, :only => [:new, :create, :edit, :update]

  def index
    @posts = Post.search(params[:search]).paginate(:per_page => $per_page,:page => params[:page])
    respond_with @posts, :location => admin_posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments(:situation => false).order('id DESC')
    respond_with @post, :location => admin_post_path
  end

  def new
    @post = Post.new
    respond_with @post, :location => new_admin_post_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.author = current_user
    flash[:notice] = 'Post salvo com sucesso !' if @post.save
    respond_with @post, :location => new_admin_post_path
  end

  def update
    @post = Post.find(params[:id])
    @post.author = current_user
    flash[:notice] = 'Post atualizado com sucesso !' if @post.update_attributes(params[:post])
    respond_with @post, :location => admin_posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    flash[:notice] = 'Post deletado com sucesso!' if @post.destroy
    redirect_to admin_posts_path
  end

protected

  def load_resources
    @categories    = Category.order(:name => 'ASC')
    @archive_types = Archive.archive_types
  end

end
