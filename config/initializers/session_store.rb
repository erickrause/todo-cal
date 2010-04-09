# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_todo-cal_session',
  :secret => 'f03d6067933e0d338e2e7bb70e4d263cc9ec874e22f1636445a26e7a30dd72927c04617a61b021b2bf5df5fdb814e66a0accf86bfe2ddb82320a8364bcd8559f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
