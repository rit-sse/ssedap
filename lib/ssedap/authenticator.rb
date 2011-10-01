module SSEDAP
  module Authenticator
    class Base
      def initialize
        raise NotImplementedError
      end

      def authenticate
        raise NotImplementedError
      end
    end
  end
end

