require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

# Load application ENV vars and merge with existing ENV vars.
ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}

module CMOA
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # precompile
    config.assets.precompile = %w(*.png *.jpg *.jpeg *.gif main.css)

    # Modify form field with error view
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "#{html_tag}".html_safe
    }


    # GZip responses
    config.middleware.use Rack::Deflater

    # Paperclip S3
    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => {
        :bucket => ENV['s3_bucket'],
        :access_key_id => ENV['s3_key'],
        :secret_access_key => ENV['s3_secret']
      },
      :url => ':s3_domain_url',
      :path => ':uuid/:style.:content_type_extension',

    }
    #github
    config.github_url = 'https://github.com/CMP-Studio/cmoa-app-cms'

    #Error handeling
    config.exceptions_app = self.routes
  end
end
