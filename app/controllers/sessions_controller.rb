# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, expect: [:destroy]
  prepend_before_action :authenticate_with_two_factor, only: :create
  skip_before_action :check_mfa

  def new
    @user = User.new
  end

  def create; end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end

  private

  def authenticate_with_two_factor
    user = User.find_by(email: params[:email])
    if user.blank?
      render action: 'new'
      return
    end
    session[:email] = params[:email]
    session[:password] = params[:password]

    redirect_to new_user_mfa_session_path
  end
end
