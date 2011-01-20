require 'net/ldap'

module Omniauth
  module Pubcookie
    module CMULdap
      # Thanks to Marshall Roch for the original jump start for this code.

      def lookup_andrew_id username
        ldap = Net::LDAP.new :host => 'ldap.andrew.cmu.edu', :port => 389

        filter = Net::LDAP::Filter.eq('cmuAndrewID', username)
        attrs = ['givenName', 'sn', 'nickname', 'eduPersonSchoolCollegeName',
                 'cmuStudentClass', 'mail', 'cmuPreferredMail',
                 'cmuPersonPrincipalName']

        ldap.search(:base => 'ou=Person,dc=cmu,dc=edu', :attributes => attrs,
                    :filter => filter, :return_result => true) do |entry|
          results = {}

          entry.each do |attribute, values|
            results[attribute] = values.first
          end

          return results
        end

        nil
      end

    end
  end
end