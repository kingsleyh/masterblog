class Admin::UploadsController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin_layout'

  def new
    @uploads = Upload.all
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    @uploads = Upload.all
    if @upload.save
      redirect_to admin_new_upload_path
    else
      render admin_new_upload_path
    end
  end

  def delete
    Upload.find(params[:id]).destroy
    redirect_to admin_new_upload_path
  end
end