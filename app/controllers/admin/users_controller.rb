class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :update
  layout 'admin_layout'

  def show
    @users = User.all
  end

  def update
    value = params[:value]
    user = User.find_by_id(params[:id])
    user.admin = value == "true"
    user.save
    render :text => user.admin
  end

  def delete
    User.find(params[:id]).destroy
    redirect_to admin_show_users_path
  end
end