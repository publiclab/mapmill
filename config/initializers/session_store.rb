# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mapmill_session',
  :secret      => 'a3db6f5237f6c9eeac578285a59b0605dc40ee2eaf9cbbadfcb96fe1d5212e07e46d735157690d5dabb6b07e25987a5d3c1766347c2493e5e5de36ebac25499c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
