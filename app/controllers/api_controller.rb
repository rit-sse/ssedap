class ApiController < ApplicationController
  layout nil

  OK_STATUS = 200
  NO_SSL_STATUS = 400
  UNAUTHORIZED_STATUS = 401
  UNDEFINED_METHOD_STATUS = 404

  def no_ssl_error
    render json: { error: "#{params[:method]} may only be accessed via SSL." }, status: 400
  end

  def undefined_method
    render json: { error: "#{params[:method]} is not defined." }, status: 404
  end

  def authorize
    resp = { success: true, user: params["username"] }
    resp_status = OK_STATUS

    options = {
      host: "ldap.rit.edu",
      port: 636,
      encryption: :simple_tls,
      base: "ou=people,dc=rit,dc=edu",
      uid: "uid"
    }
    ldap_auth = SSEDAP::Authenticator::LDAP.new options

    unless ldap_auth.authenticate params["username"], params["password"]
      resp[:success] = false
      resp[:error] = ldap_auth.op_result
      resp_status = UNAUTHORIZED_STATUS
    end

    render json: resp, status: resp_status
  end
end

