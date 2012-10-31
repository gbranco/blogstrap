class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :atualizar_situation, :only => :index

  def index
    @categories = Category.search(params[:search]).paginate(:per_page => $per_page,:page => params[:page])
    respond_with @categories,:location => admin_categories_path
  end

  def show
    @category = Category.find(params[:id])
    respond_with @category,:location => admin_category_path
  end

  def new
    @category = Category.new
    respond_with @category, :location => new_admin_category_path
  end

 
  def edit
    @category = Category.find(params[:id])
  end

  
  def create
    @category = Category.new(params[:category])
    flash[:notice] = 'Categoria  criada com sucesso!' if @category.save
    respond_with @category,:location => new_admin_category_path
  end

  def update
    @category = Category.find(params[:id])
    flash[:notice] = 'Categoria atualizado com sucesso!' if @category.update_attributes(params[:category])
    respond_with @category,:location => admin_categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    flash[:notice] = 'Categoria deletado com sucesso' if @category.destroy
    redirect_to admin_categories_path
  end

end

