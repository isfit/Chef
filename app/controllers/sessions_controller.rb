class SessionsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new

  end

  def create
    user = User.find_by_username(params[:username])
    if user && !user.password_digest.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => "Logget inn."
    elsif user
      flash.now[:error] = "Ikke autorisert for innlogging."
      render :action => 'new'
    else
      flash.now[:error] = "Ugyldig brukernavn eller passord."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => "Logget ut."
  end
end
