class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?

  Markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                     :autolink => true, :space_after_headers => true)

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return 1 if current_user
  end

  def authenticate_user!
    if !current_user
      flash[:error] = 'You need to sign in before accessing this page!'
      redirect_to admin_signin_path
    end

    if current_user
      if !current_user.admin
        if current_user.id == User.first.id
          u = User.first
          if u.admin == false
            u.admin = true
            u.save
            flash[:success] = 'Since you are the first user you have been granted admin rights'
          end
          redirect_to admin_index_path
        else
          flash[:error] = 'You must be an admin to access this page!'
          redirect_to admin_signin_path
        end
      end
    end
  end
end
