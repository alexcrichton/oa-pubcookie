OmniAuth::Pubcookie
===================

This gem implements two strategies, `OmniAuth::Strategies::Pubcookie` and `Omniauth::Strategies::CMU`. The syntax between the two is similar and can be instantiated like so:

    use OmniAuth::Strategies::Pubcookie, :login_server => '...', :host => '...',
      :appid => '...', :keyfile => '...', :granting_cert => '...'

See [rack-pubcookie](https://github.com/alexcrichton/rack-pubcookie) for specific information on what each key is and how to get it

## CMU Integration

CMU (Carnegie Mellon University) uses WebISO for it's authentication. This service is backed by pubcookie. CMU also has an LDAP service, making this pair perfect for OmniAuth. The two have been unified with this gem and can be used as follows:

    use OmniAuth::Strategies::CMU, :host => '...', :appid => '...', :keyfile => '...'

The only difference is that neither `:login_server` nor `:granting_cert` need to be specified and will default to `webiso.andrew.cmu.edu` and CMU's granting certificate.

The returning `omniauth.auth` hash complies with the [Omniauth Hash Schema](https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema) and as such has the following keys:

* `uid` - the user's Andrew iD
* `user_info`
  * `name` - the user's full name
  * `email` - the user's preferred CMU email
  * `nickname`
  * `first_name`
  * `last_name`
  * `location` - the campus which the user is located at (Pittsburgh/Qatar)
* `extra`
  * `class` - the users' year at CMU (Freshman, Sophomore, ...)
  * `department` - the listed department for the user (i.e. Computer Science)
  * `raw_info` - everything returned from LDAP for the user, you might find something extra in here
