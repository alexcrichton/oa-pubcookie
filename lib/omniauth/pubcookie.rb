require 'omniauth'

module OmniAuth
  module Pubcookie
    autoload :VERSION, 'omniauth/pubcookie/version'
    autoload :CMULdap, 'omniauth/pubcookie/cmu_ldap'
  end

  module Strategies
    autoload :CMU, 'omniauth/strategies/cmu'
    autoload :Pubcookie, 'omniauth/strategies/pubcookie'
  end
end
