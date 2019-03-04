# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :check_mfa

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end

  def check_mfa
    if !(user_mfa_session = UserMfaSession.find) && (user_mfa_session ? user_mfa_session.record == current_user : !user_mfa_session)
      logout
      redirect_to new_session_path
    end
  end
end
