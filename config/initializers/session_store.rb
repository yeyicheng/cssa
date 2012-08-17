# Be sure to restart your server when you modify this file.

Cssa::Application.config.session_store :cookie_store, key: '_cssa_session'

Cssa::Application.config.session = {
  :key          => '_omniauthpure_session',     # name of cookie that stores the data
  :domain       => nil,                         # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month,                     # expire cookie
  :secure       => false,                       # fore https if true
  :httponly     => true,                        # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret      => 'e558fa9c01dfc6b8fc4fb5c9919cb80e4e5414346cfd356a061438dd15cdeaad86652634c06f4ac5bfa929056e2e50a5b15d976dbe4a04dd4c45cc96c293ed57'
}
