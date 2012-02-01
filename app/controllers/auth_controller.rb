class AuthController < ApplicationController
  def index
    redirect_to root_path if signed_in?
  end

  def authorize
    client = SSEDAP::Client.new Settings.ssedap_location
    auth_hash = client.authorize params[:username], params[:password]
    logger.debug auth_hash

    if auth_hash["data"]["success"]
      username = auth_hash["data"]["user"]
      role = auth_hash["data"]["user_info"]["role"]
      set_current_user username, role

      redirect_to dashboard_path, notice: "Logged in successfully."
    else
      flash[:notice] = "Error: #{auth_hash["data"]["error"]}"
      render :index
    end
  end

  def logout
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end

