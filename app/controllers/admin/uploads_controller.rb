class Admin::UploadsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :authenticate_user!, :except => [:create]
  layout 'admin_layout'


  def new
    @uploads = Upload.all
    @upload = Upload.new
  end

  def create
    params[:upload][:upload].content_type = MIME::Types.type_for(params[:upload][:upload].original_filename).first.to_s
    @upload = Upload.new
    @upload.upload = params[:upload][:upload]
    @uploads = Upload.all
    if @upload.save
       render :json => { 'status' => 'success'  }
    else
       render :json => { 'status' => 'error' }
    end
  end

  def delete
    Upload.find(params[:id]).destroy
    redirect_to admin_new_upload_path
  end
end