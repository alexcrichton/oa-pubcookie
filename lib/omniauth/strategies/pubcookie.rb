require 'omniauth/strategy'
require 'rack/pubcookie'

module Omniauth
  module Strategies
    class Pubcookie

      include Omniauth::Strategy
      include Rack::Pubcookie::Auth

      def initialize app, options, &block
        self.pubcookie_options = options
        super app, :pubcookie, &block
      end

      def request_phase
        Rack::Response.new(login_page_html).finish
      end

      def callback_phase
        username = extract_username request
        request.env['REMOTE_USER'] = username # Part of the pubcookie spec

        if username
          request.env['omniauth.auth'] = auth_hash(username)

          status, headers, body = call_app!

          # Set the actual cookie for pubcookie, as per its spec
          response = Rack::Response.new body, status, headers
          set_pubcookie! request, response

          response.finish
        else
          fail! :login_failed
        end
      end

      def auth_hash username
        OmniAuth::Utils.deep_merge(super(), {
          'uid'       => username,
          'provider'  => 'pubcookie',
          'user_info' => {'name' => username}
        })
      end

    end
  end
end
