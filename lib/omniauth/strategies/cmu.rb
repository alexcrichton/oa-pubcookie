require 'omniauth/strategies/pubcookie'

module OmniAuth
  module Strategies
    class CMU < Pubcookie

      GRANTING = File.expand_path('../cmu_granting.cert', __FILE__)

      include OmniAuth::Pubcookie::CMULdap

      def pubcookie_options= options
        options[:login_server] ||= 'webiso.andrew.cmu.edu'
        options[:granting_cert] ||= GRANTING

        super
      end

      def auth_hash username
        andrew_id = username.match(/^(.*)@/)[1]

        attrs = lookup_andrew_id(andrew_id)

        OmniAuth::Utils.deep_merge(super, {
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
