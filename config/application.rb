require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AssignTasks
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.test_framework :rspec,
                       view_spec:false,
                       fixtures: true,
                       helper_spec: false,
                       routing_spec: false,
                       request_spec: false,
                       controller_spec: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
