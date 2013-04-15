Loomio::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  if ENV['TEST_EMAIL'] == 'sendgrid'
    # Send emails using SendGrid
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => 'loomio.org'

      #enable_starttls_auto: true
    }
    config.action_mailer.default_url_options = {
      :host           => 'johnsloomiotest.herokuapp.com', #looimo-staging.herokuapp.com',
    }
    config.action_mailer.perform_deliveries = true

  elsif ENV['TEST_EMAIL'] == 'mailcatcher'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address        => 'localhost',
      :port           => 1025,
      :domain         => 'loomio.org'
    }
    config.action_mailer.default_url_options = {
      :host           => 'loomio.org'
    }
    config.action_mailer.perform_deliveries = true
  else
    config.action_mailer.delivery_method = :test
    config.action_mailer.default_url_options = {
      :host           => 'localhost:3000'
    }
  end

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.action_mailer.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => "localhost",
    :port => 1025,
    :domain => "tautoko.co.nz" }
end
