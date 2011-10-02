class ApiController < ActionController::Base
  layout nil

  OK_STATUS = 200
  NO_SSL_STATUS = 400
  UNAUTHORIZED_STATUS = 401
  UNDEFINED_METHOD_STATUS = 404
  INTERNAL_SERVER_ERROR_STATUS = 500

  def no_ssl_error
    render json: { error: "The API method '#{params[:method]}' may only be accessed via SSL." }, status: 400
  end

  def undefined_method
    render json: { error: "The API method '#{params[:method]}' is not defined." }, status: 404
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
      # look up params["username"] in mongo
      resp[:user_info] = {}
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
      # look up params["lookup"] in mongo
      resp[:user_info] = {}
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
      success = ldap_auth.authenticate(username: username, password: password)
      unless success
        status_code = UNAUTHORIZED_STATUS
        error_string = "LDAP error #{ldap_auth.op_result.code}: #{ldap_auth.op_result.message}"
      end
    rescue
      success = false
      status_code = INTERNAL_SERVER_ERROR_STATUS
      error_string = $!.to_s
    end

    { success: success, status: status_code, message: error_string }
  end
end

