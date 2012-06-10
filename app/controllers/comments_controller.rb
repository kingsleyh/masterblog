class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to params[:return_path]
    else
      flash[:error] = "Error: Name and Message are required"
      redirect_to params[:return_path]
    end
  end

end
