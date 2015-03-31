Myflix::Application.configure do
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :letter_opener
  #config.action_mailer.delivery_method = :smtp
  #config.action_mailer.smtp_settings = {
  #  :address         => "smtp.mailgun.org",
  #  :port            => 587,
  #  :user_name       => "postmaster@sandbox464981ee94a0420f82752f39ae7be18f.mailgun.org",
  #  :password        => "GDisback",
  #  :domain          => "sandbox464981ee94a0420f82752f39ae7be18f.mailgun.org",
  #  :authentication  => :plain
  #}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false
  

end
