require 'net/ldap'

module OmniAuth
  module Pubcookie
    module CMULdap
      # Thanks to Marshall Roch for the original jump start for this code.

      def lookup_andrew_id username
        ldap = Net::LDAP.new :host => 'ldap.andrew.cmu.edu', :port => 389

        filter = Net::LDAP::Filter.eq('cmuAndrewID', username)
        ldap.search(:base => 'ou=Person,dc=cmu,dc=edu',
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
