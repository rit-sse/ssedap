class SessionsController < ApplicationController
  def authorize
    resp = { success: true, user: params["username"] }

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
    end

    render :json => resp
  end
end

