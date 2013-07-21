require 'yaml'

APP_CONFIG = YAML::load( File.open( 'config/app_config.yml' ) )[ENV['RAILS_ENV'] || 'development']

