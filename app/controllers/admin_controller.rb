class AdminController < ApplicationController
  before_filter :authenticate_user!, :except => [:login]
  layout 'admin_layout'

  def index
    @articles = Article.all
  end

  def login
    render :layout => 'login_layout'
  end

end
