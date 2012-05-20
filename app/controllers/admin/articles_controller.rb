class Admin::ArticlesController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin_layout'

  def new
   @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to admin_index_path
    else
      render admin_new_article_path
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to admin_index_path
    else
      render edit_article_path
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def delete
    Article.find(params[:id]).destroy
    redirect_to admin_index_path
  end
end
