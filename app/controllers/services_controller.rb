class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :signup, :newaccount, :failure]
  protect_from_forgery :except => :create
  layout 'signup_layout'


  # GET all authentication services assigned to the current user
  #def index
  #  @services = current_user.services.order('provider asc')
  #end

  # POST to remove an authentication service
  #def destroy
  #  # remove an authentication service linked to the current user
  #  @service = current_user.services.find(params[:id])
  #
  #  if session[:service_id] == @service.id
  #    flash[:info] = 'You are currently signed in with this account!'
  #  else
  #    @service.destroy
  #  end
  #
  #  redirect_to services_path
  #end

  def signup
    @authhash = session[:authhash]
    if @authhash.nil?
      redirect_to root_url
    end
  end

  # POST from signup view
  def newaccount
    if params[:commit] == "Cancel"
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
    else # create account
      @newuser = User.new
      @newuser.name = session[:authhash][:name]
      @newuser.email = session[:authhash][:email]
      @newuser.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])

      if @newuser.save!
        # signin existing user
        # in the session his user id and the service id used for signing in is stored
        session[:user_id] = @newuser.id
        session[:service_id] = @newuser.services.first.id

        flash[:success] = 'Your account has been created and you have been signed in!'
        redirect_to admin_index_path
      else
        flash[:error] = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
        redirect_to admin_signin_path
      end
    end
  end

  # Sign out current user
  def signout
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:success] = 'You have been signed out!'
    end
    redirect_to admin_signin_path
  end

  # callback: success
  # This handles signing in and adding an authentication service to existing accounts itself
  # It renders a separate view if there is a new user to create
  def create
    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']

    # continue only if hash and parameter exist
    if omniauth and params[:service]

      # map the returned hashes to our variables first - the hashes differs for every service

      # create a new hash
      @authhash = Hash.new

      if service_route == 'facebook'
        omniauth['extra']['raw_info']['email'] ? @authhash[:email] = omniauth['extra']['raw_info']['email'] : @authhash[:email] = ''
        omniauth['extra']['raw_info']['name'] ? @authhash[:name] = omniauth['extra']['raw_info']['name'] : @authhash[:name] = ''
        omniauth['extra']['raw_info']['id'] ? @authhash[:uid] = omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      end

      if @authhash[:uid] != '' and @authhash[:provider] != ''
        auth = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])

        if user_signed_in?
          if auth
            #flash[:info] = 'You are already logged in via ' + @authhash[:provider].capitalize
            redirect_to admin_index_path
            #else
            #  current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])
            #  flash[:success] = 'Your ' + @authhash[:provider].capitalize + ' account has been added for signing in at this site.'
            #  redirect_to admin_index_path
          end
        else
          if auth
            # signin existing user
            # in the session his user id and the service id used for signing in is stored
            session[:user_id] = auth.user.id
            session[:service_id] = auth.id

            flash[:success] = 'Signed in successfully via ' + @authhash[:provider].to_s.capitalize + '.'
            redirect_to admin_index_path
          else
            # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
            session[:authhash] = @authhash
            render signup_services_path
          end
        end
      else
        flash[:error] = 'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
        redirect_to admin_signin_path
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid data.'
      redirect_to admin_signin_path
    end

  end

  # callback: failure
  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    redirect_to root_url
  end
end