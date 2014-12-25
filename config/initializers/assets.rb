# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( session.js )
Rails.application.config.assets.precompile += %w( session.css )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( sites.js )
Rails.application.config.assets.precompile += %w( sites.css )
#Rails.application.config.assets.precompile += %w( tmpl.min.js )
#Rails.application.config.assets.precompile += %w( jquery.fileupload*.js )
