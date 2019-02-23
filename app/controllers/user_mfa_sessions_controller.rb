class UserMfaSessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :check_mfa

  def new
    @user = User.find_by(email: session[:email])
  end

  def create
    email = session[:email]
    password = session[:password]
    @user = User.find_by(email: email)
    if @user.google_authentic?(params[:auth][:mfa_code])
      reset_session
      if login(email, password)
        unless @user.first_twofactor_logged_in
          @user.update!(first_twofactor_logged_in: true)
        end
        UserMfaSession.create(@user)
        redirect_to(root_path)
      else
        redirect_to new_session_path
      end
    else
      redirect_to new_session_path
    end
  end
end
