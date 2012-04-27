class AuthController < ApplicationController
  def index
    redirect_to root_path if signed_in?
  end

  def authorize
    client = SSEDAP::Client.new Settings.ssedap_location
    auth_hash = client.authorize params[:username], params[:password]
    logger.debug auth_hash

    error_notice = nil

    if auth_hash["data"]["success"]
      username = auth_hash["data"]["user"]
      role = auth_hash["data"]["user_info"]["role"]

      Rails.logger.info "Login attempt with role #{role}."

      if role == "Admin" or role == "Officer"
        set_current_user username, role

        redirect_to dashboard_path, notice: "Logged in successfully."
      else
        error_notice = "Error: insufficient privileges."
      end
    else
      error_notice = "Error: #{auth_hash["data"]["error"]}"
    end

    if error_notice 
      flash[:notice] = error_notice
      render :index
    end
  end

  def logout
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end

