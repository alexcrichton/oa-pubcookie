# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/pubcookie/version'

Gem::Specification.new do |s|
  s.name        = 'oa-pubcookie'
  s.version     = Omniauth::Pubcookie::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alex Crichton']
  s.email       = ['alex@crichton.co']
  s.homepage    = 'https://github.com/alexcrichton/oa-pubcookie'
  s.summary     = 'Omniauth strategy using pubcookie'
  s.description = 'Omniauth strategy using pubcookie with special additions for CMU students where information is fetched via LDAP'

  s.files         = `git ls-files lib`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'rack-pubcookie'
  s.add_dependency 'oa-core'
  s.add_dependency 'net-ldap'
end
