class Admin::SnippetsController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin_layout'

  def new
    @uploads = Upload.all
    @snippets = Snippet.all
    @snippet = Snippet.new
  end

  def create
    @uploads = Upload.all
    @snippets = Snippet.all
    @snippet = Snippet.new(params[:snippet])
    if @snippet.save
      redirect_to admin_new_snippet_path
    else
      render admin_new_snippet_path
    end
  end

  def update
    @uploads = Upload.all
    @snippets = Snippet.all
    @snippet = Snippet.find(params[:id])
    if @snippet.update_attributes(params[:snippet])
      redirect_to admin_edit_snippet_path(@snippet.id)
    else
      render admin_edit_snippet_path(@snippet.id)
    end
  end

  def edit
    @uploads = Upload.all
    @snippets = Snippet.all
    @snippet = Snippet.find(params[:id])
  end

  def delete
    Snippet.find(params[:id]).destroy
    redirect_to admin_new_snippet_path
  end
end