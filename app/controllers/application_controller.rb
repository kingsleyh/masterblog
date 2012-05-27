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
    end
end
