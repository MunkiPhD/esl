source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.2.rc1'

#gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '>= 3.2' #,   '~> 4.0.0.beta1'
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'coffee-rails' #, '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg'
gem 'devise' #, git: 'https://github.com/plataformatec/devise.git', branch: 'rails4'
gem 'cancan'
gem 'rolify', git: 'https://github.com/EppO/rolify.git'
gem 'will_paginate', '~> 3.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'paperclip', '~> 4.1'
gem 'aws-sdk', '~> 1.5.7'

group :development do
  gem "annotate"
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'timecop'
  gem 'launchy'
  gem 'rspec', '~>2.99.0.beta1'
  gem "rspec-rails"
end

group :test do
  gem "factory_girl_rails"
  #gem "capybara", "~> 2.2.0"
  gem 'capybara', git: 'https://github.com/jnicklas/capybara.git'
  gem "fuubar"
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-collection_matchers'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
gem 'debugger'

