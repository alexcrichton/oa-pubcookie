module Omniauth
  module Strategies
    class CMU < Rack::Pubcookie::Auth
      include Omniauth::Strategy
      include Rack::Pubcookie::Auth

      def initialize
      end

      def request_phase
        Rack::Response.new(login_page_html).finish
      end

      def callback_phase
        username = extract_username request
        
        if username
          
        else
          fail! :login_failed
        end
      end

    end
  end
end
