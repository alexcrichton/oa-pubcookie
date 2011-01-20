require 'omniauth/strategies/pubcookie'

module OmniAuth
  module Strategies
    class CMU < Pubcookie

      include OmniAuth::Pubcookie::CMULdap

      def auth_hash username
        andrew_id = username.match(/^(.*)@/)[0]

        attrs = lookup_andrew_id(andrew_id)

        OmniAuth::Utils.deep_merge(super(), {
          'uid'       => andrew_id,
          'provider'  => 'cmu',
          'user_info' => {
            'name'       => attrs[:cn],
            'email'      => attrs[:mail],
            'nickname'   => attrs[:nickname],
            'first_name' => attrs[:givenname],
            'last_name'  => attrs[:sn],
            'class'      => attrs[:cmustudentclass],
            'department' => attrs[:cmudepartment],
            'location'   => attrs[:cmucampus]
          },
          'extra' => {'user_hash' => attrs}
        })
      end

    end
  end
end
