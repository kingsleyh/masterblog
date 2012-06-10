class Admin::CommentsController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin_layout'

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to admin_index_path
    else
      render admin_edit_comment_path(@comment.id)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def delete
    Comment.find(params[:id]).destroy
    redirect_to admin_index_path
  end

end