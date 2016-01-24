# encoding: utf-8
Rails.application.configure do
  if ENV['NO_CACHE_CLASS'].present?
    config.cache_classes = false
  else
    config.cache_classes = true
  end

  config.eager_load = true
  config.consider_all_requests_local = false

  # config.cache_store = :dalli_store, (ENV["MEMCACHIER_SERVERS"] || "").split(","),
  #                   {:username => ENV["MEMCACHIER_USERNAME"],
  #                    :password => ENV["MEMCACHIER_PASSWORD"],
  #                    :pool_size => 3,
  #                    :failover => true,
  #                    :socket_timeout => 1.5,
  #                    :compress => true,
  #                    :socket_failure_delay => 0.2
  #                   }

  config.action_controller.perform_caching = true
  config.static_cache_control = "public, max-age=30000000"
  config.serve_static_assets = true
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new


  config.action_mailer.default_url_options = { :host => 'kourti.herokuapp.com' }  
  config.action_mailer.delivery_method = :smtp  
  config.action_mailer.perform_deliveries = true  
  config.action_mailer.raise_delivery_errors = false  
  config.action_mailer.default :charset => "utf-8"  
  config.action_mailer.smtp_settings = {  
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => 'kourti.contact@gmail.com',
    :password       => 'kourti123',
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }

end
