#coding : utf-8
class Admin::UsersController < ApplicationController
  load_and_authorize_resource
	layout 'admin'
  before_filter :authenticate_user!
  before_filter :atualizar_situation, :only => :index
  before_filter :load_roles, :only => [:new, :create, :update, :edit]
 
  def index
    @users = User.search(params[:search]).paginate(:per_page => $per_page,:page => params[:page])
    respond_with @users, :location => admin_users_path
  end

  def show
  	@user = User.find(params[:id])
  	respond_with @user, :location => admin_user_path
  end

  def edit
  	@user = User.find(params[:id])
  end

	def new
		@user = User.new
		respond_with @user, :location => new_admin_user_path
	end


	def create
		@user = User.new(params[:user])
		flash[:notice] = 'Usuário criado com sucesso !' if @user.save
		respond_with @user, :location => admin_users_path
	end

	def update
    @user = User.find(params[:id])
    flash[:notice] = 'Usuário atualizado com sucesso!' if @user.update_attributes(params[:user])
    respond_with @user, :location => admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = 'Categoria deletado com sucesso' if @user.destroy
    redirect_to admin_users_path
  end

protected

  def load_roles
    @roles = Role.order(:name => 'ASC')
  end

end
