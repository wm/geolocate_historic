# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_geolocate_histroic_session',
  :secret      => '94266f0d5b39014e67e1bf73a9c332022c2e2d735b18af3b8c7e3e7c2c4f6249f6c2e4c951be3923c8af1df0e4d1c99476b05637e22244bff3025a585aab9418'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
