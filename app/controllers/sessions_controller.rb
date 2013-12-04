class SessionsController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, :only => [:new]
  before_filter :setup_cas_user, :only => [:new]
  def new
    redirect_to root_path
  end

  # def create
    # @user = User.find_by_email(params[:email])
    # if @user && @user.authenticate(params[:password])
        # sign_in @user
        # redirect_back_or root_path
    # else
      # flash.now[:error] = 'Invalid email/password combination'
      # render 'new'
    # end
  # end

  def destroy
    sign_out
    CASClient::Frameworks::Rails::Filter.logout(self)
    respond_to do |format|
      format.html {
      }
    end
  end

  def setup_cas_user
      # save the login_url into an @var so that we can later use it in views (eg a login form)
      #@login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
      return unless session[:cas_user].present?

      # so now we go find the user in our db
      @current_user = User.find_by_email(session[:cas_user])
      sign_in(@current_user) if @current_user.present?
  end

end
