require 'omniauth/strategies/pubcookie'

module OmniAuth
  module Strategies
    class CMU < Pubcookie

      include OmniAuth::Pubcookie::CMULdap

      option :login_server, 'webiso.andrew.cmu.edu'
      option :granting_cert, File.expand_path('../cmu_granting.cert', __FILE__)
      option :name, 'pubcookie' # otherwise it thinks the provider is cmu

      info do
        {
          :name       => raw_info[:name],
          :email      => raw_info[:email],
          :nickname   => raw_info[:nickname],
          :first_name => raw_info[:first_name],
          :last_name  => raw_info[:last_name],
          :location   => raw_info[:location]
        }
      end

      extra do
        {
          :department => raw_info[:department],
          :class      => raw_info[:class],
          :raw_info   => raw_info[:ldap_attrs]
        }
      end

      def raw_info
        if @raw_info.nil?
          username  = extract_username(request)
          andrew_id = username.match(/^(.*)@/)[1]
          attrs     = lookup_andrew_id andrew_id

          @raw_info = {
            :username   => andrew_id,
            :name       => attrs[:cn],
            :email      => attrs[:mail],
            :nickname   => attrs[:nickname],
            :first_name => attrs[:givenname],
            :last_name  => attrs[:sn],
            :class      => attrs[:cmustudentclass],
            :department => attrs[:cmudepartment],
            :location   => attrs[:cmucampus],
            :ldap_attrs => attrs
          }
        end

        @raw_info
      end
    end
  end
end
