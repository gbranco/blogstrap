class Admin::ArchivesController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :authenticate_user!
  
  def index
    @archives = Archive.paginate(:per_page => $per_page, :page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archives.map{|archive| archive.to_jq_upload } }
    end
  
  end

  def create
    p_attr = params[:archive]
    p_attr[:image] = params[:archive][:image].first if params[:archive][:image].class == Array

    @archive = Archive.new(p_attr)
    if @archive.save
      respond_to do |format|
        format.html {  
          render :json => [@archive.to_jq_upload].to_json, 
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@archive.to_jq_upload].to_json, status: :created, location: admin_archives_path }
      end
    else 
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @archive = Archive.find(params[:id])
    flash[:alert] = 'Arquivo deletado com sucesso !' if @archive.destroy
    redirect_to admin_archives_path
  end
end
