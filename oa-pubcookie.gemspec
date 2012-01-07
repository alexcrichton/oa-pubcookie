# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/pubcookie/version'

Gem::Specification.new do |s|
  s.name        = 'oa-pubcookie'
  s.version     = OmniAuth::Pubcookie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alex Crichton', 'Stafford Brunk']
  s.email       = ['alex@crichton.co', 'stafford.brunk@gmail.com']
  s.homepage    = 'https://github.com/alexcrichton/oa-pubcookie'
  s.summary     = 'Omniauth strategy using pubcookie'
  s.description = 'Omniauth strategy using pubcookie with special additions for CMU students where information is fetched via LDAP'

  s.files         = `git ls-files lib`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'rack-pubcookie', '>= 0.0.3'
  s.add_dependency 'oa-core'
  s.add_dependency 'net-ldap'
end
