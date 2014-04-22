# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#
# If delpoying on Heroku,
# run:
#   rake secret
# This will generate a new secret, then
#   heroku config:set SECRET_TOKEN={{the secret token here }}
#
# Then, after setting the environment variable, you do can do the code push
#   git push heroku master
#
# Or if you are deploying somewhere else, you can do it directly in the shell
#   SECRET_TOKEN=the_secret_token rails server
#
#if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
#  raise 'SECRET_TOKEN has not been set on the environment variable. Must be set to run!'
#end

#Esl::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '80eeca21c8e0becb16f8ba7c37b7c6a2ede464dbfec85dd1263044c628bdda2fe451334c4824c4b2934cde9e4c1ec039b0198aba033b4fb34c831593269e9153'
