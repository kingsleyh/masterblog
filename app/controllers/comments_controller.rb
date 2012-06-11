class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    if @comment.authenticate_captcha($captcha_key, params[:captchator])
      if @comment.save
        redirect_to params[:return_path]
      else
        flash[:error] = "Error: Name and Message are required"
        session[:comment_name] = @comment.name
        session[:comment_email] = @comment.email
        session[:comment_content] = @comment.content
        redirect_to params[:return_path]
      end
    else
      flash[:error] = "Error: Captch was incorrect - try again!"
      session[:comment_name] = @comment.name
      session[:comment_email] = @comment.email
      session[:comment_content] = @comment.content
      redirect_to params[:return_path]
    end
  end

end
