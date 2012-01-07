require 'omniauth/strategy'
require 'rack/pubcookie'

module OmniAuth
  module Strategies
    class Pubcookie

      include OmniAuth::Strategy
      include Rack::Pubcookie::Auth

      option :return_to, '/auth/pubcookie/callback'

      # Override initialize.  Omniauth frowns on this
      # but we need to set pubcookie_options on initialize
      def initialize(app, *args, &block)
        super(app, *args, &block)
        self.pubcookie_options = options
      end

      def request_phase
        @raw_info = nil
        Rack::Response.new(login_page_html).finish
      end

      def callback_phase
        # Part of the pubcookie spec
        request.env['REMOTE_USER'] = raw_info[:username]

        if raw_info[:username]
          self.env['omniauth.auth'] = auth_hash # provided by Omniauth now
          request.env['REQUEST_METHOD'] = 'GET'

          status, headers, body = call_app!

          # Set the actual cookie for pubcookie, as per its spec
          response = Rack::Response.new body, status, headers
          set_pubcookie! request, response

          response.finish
        else
          fail! :login_failed
        end
      end

      # unique user id
      uid { raw_info[:username] }

      info do
        {'name' => raw_info[:username]}
      end

      def raw_info
        @raw_info ||= {:username => extract_username(request)}
      end
    end
  end
end
