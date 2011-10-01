module SSEDAP
  module Authenticator
    class LDAP < Base
      # all of these are **required** for successful authentication
      attr_accessor :host, :port, :encryption, :base, :uid

      # can optionally set necessary params at the time of instantiation
      # e.g. ldap_auth =
      #       SSEDAP::Authenticator::LDAP.new(host: "ldap.example.org", 
      #                               port: 636, encryption: :simple_tls)
      def initialize(*args)
        if args.last.is_a?(Hash)
          args.each do |k,v|
            self.send("#{k}=", v) if self.respond_to?("#{k}=".to_sym)
          end
        end
      end

      # authenticate takes a hash with :username and :password, where :username
      # corresponds to the value for the @uid key
      #
      # returns a boolean indicating success
      def authenticate(credentials)
        @ldap = Net::LDAP.new(host: @host, port: @port, encryption: @encryption)
        @ldap.auth "#{@uid}=#{credentials[:username]},#{@base}", "#{credentials[:password]}"
        @ldap.bind
      end

      # the last ldap operation result
      def op_result
        @ldap.get_operation_result if @ldap
      end
    end
  end
end

