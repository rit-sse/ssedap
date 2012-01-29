class ApiController < ActionController::Base
  layout nil

  OK_STATUS = 200
  NO_SSL_STATUS = 400
  UNAUTHORIZED_STATUS = 401
  NOT_FOUND_STATUS = 404
  UNDEFINED_METHOD_STATUS = 501
  INTERNAL_SERVER_ERROR_STATUS = 500

  def no_ssl_error
    render json: { error: "The API method '#{params[:method]}' may only be accessed via SSL." }, status: NO_SSL_STATUS
  end

  def undefined_method
    render json: { error: "The API method '#{params[:method]}' is not defined." }, status: UNDEFINED_METHOD_STATUS
  end

  def authorize
    resp = { success: true, user: params["username"] }
    resp_status = OK_STATUS

    result = ldap_authenticate(params["username"], params["password"])
    unless result[:success]
      resp[:success] = false
      resp[:error] = result[:message]
      resp_status = result[:status]
    else
      user = DirectoryUser.where(username: params["username"]).first

      if user.nil?
        resp[:success] = false
        resp[:error] = "User '#{params["username"]}' not found in SSEDAP."
        resp_status = UNAUTHORIZED_STATUS
      else
        resp[:user_info] = user.auth_attributes
      end
    end

    render json: resp, status: resp_status
  end

  def userinfo
    resp = { success: true, user: params["username"], lookup: params["lookup"] }
    resp_status = OK_STATUS

    result = ldap_authenticate(params["username"], params["password"])
    unless result[:success]
      resp[:success] = false
      resp[:error] = result[:message]
      resp_status = result[:status]
    else
      user = DirectoryUser.where(username: params["username"]).first

      if user.nil?
        # check existence of admin/officer user

        resp[:success] = false
        resp[:error] = "User '#{params["username"]}' not found in SSEDAP."
        resp_status = UNAUTHORIZED_STATUS
      elsif not (user.role.is_admin? or user.role.is_officer?)
        # ensure role of admin/officer user

        resp[:success] = false
        resp[:error] = "User '#{params["username"]}' does not have permissions to look up users"
        resp_status = UNAUTHORIZED_STATUS
      else
        # look up the given user
        lookup = DirectoryUser.where(username: params["lookup"]).first

        if lookup.nil?
          resp[:success] = false
          resp[:error] = "User '#{params["lookup"]}' not found in SSEDAP."
          resp_status = NOT_FOUND_STATUS
        else
          resp[:user_info] = lookup.auth_attributes
        end
      end

    end

    render json: resp, status: resp_status
  end

  private

  def ldap_authenticate(username, password)
    options = {
      host: "ldap.rit.edu",
      port: 636,
      encryption: :simple_tls,
      base: "ou=people,dc=rit,dc=edu",
      uid: "uid"
    }

    ldap_auth = SSEDAP::Authenticator::LDAP.new options

    success = true
    status_code = OK_STATUS
    error_string = ""

    begin
      # WHAT THE HELL
      # some ldap servers apparently let you bind with any old username
      # if you give it a blank password...even if the username doesn't exist 
      # in the ldap directory...so we need this check
      unless password.to_s.empty?
        success = ldap_auth.authenticate(username: username, password: password)
        
        unless success
          status_code = UNAUTHORIZED_STATUS
          # error_string = "LDAP error #{ldap_auth.op_result.code}: #{ldap_auth.op_result.message}"
          error_string = "LDAP error: #{ldap_auth.op_result.message}"
        end
      else
        success = false
        status_code = UNAUTHORIZED_STATUS
        error_string = "LDAP error: Invalid Credentials"
      end
    rescue
      success = false
      status_code = INTERNAL_SERVER_ERROR_STATUS
      error_string = $!.to_s
    end

    { success: success, status: status_code, message: error_string }
  end
end

