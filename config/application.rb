require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookshare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Bundler.require(*Rails.groups)
    config.time_zone = "Asia/Ho_Chi_Minh"
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    config.time_zone = "Asia/Ho_Chi_Minh"
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.middleware.use I18n::JS::Middleware
    config.active_record.default_timezone = :local
    config.active_job.queue_adapter = :sidekiq
    config.session_store :active_record_store
    config.generators do |g|
      g.template_engine nil #to skip views
      g.test_framework  nil #to skip test framework
      g.assets  false
      g.helper false
      g.stylesheets false
    end
  end
end
