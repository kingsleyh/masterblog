class Admin::ExtendController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => [:content]
  layout 'admin_layout'

  def content
    @parent = params[:dir]
    @dir = Jqueryfiletree.new(@parent).get_content
    render :layout => false
  end

  def new
    @systemfile = Systemfile.new()
  end

  def edit
    @systemfile = Systemfile.new()
    @systemfile.filepath = Rails.root.to_s + "/" + params[:filepath].gsub('$', "/")
    @systemfile.filename = params[:filename].gsub('$', ".")
    path = @systemfile.filepath + "/" + @systemfile.filename
    content = File.read(path)
    @systemfile.content = content
  end

  def update
    @systemfile = Systemfile.new(params[:systemfile])
    if @systemfile.valid?
      path = @systemfile.filepath + "/" + @systemfile.filename
      File.open(path, "w") { |f| f.puts @systemfile.content }
      redirect_to admin_new_extend_path
    else
      render admin_new_extend_path
    end
  end

  def create
    @systemfile = Systemfile.new(params[:systemfile])
    if @systemfile.valid?
      begin
      path = Rails.root.to_s + "/" + @systemfile.filepath + "/" + @systemfile.filename
      File.open(path, "w") { |f| f.puts @systemfile.content }
      redirect_to admin_new_extend_path
      rescue => e
        flash[:error] = "Error - #{e}"
        render admin_new_extend_path
      end
    else
      render admin_new_extend_path
    end
  end

  def delete
    @systemfile = Systemfile.new()
    @systemfile.filepath = params[:filepath].gsub('$', "/")
    @systemfile.filename = params[:filename].gsub('$', ".")
    path = @systemfile.filepath + "/" + @systemfile.filename
    if File.exists?(path)
      File.delete(path)
      flash[:success] = "File was deleted: " + path
      redirect_to admin_new_extend_path
    else
      flash[:error] = "File could not be deleted: " + path
      render admin_edit_extend_path
    end
  end


end