# encoding: utf-8
Rails.application.configure do
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true

  if false
    config.cache_classes = true
    config.eager_load = true
    config.cache_store = :dalli_store
    config.action_controller.perform_caching = true
    config.consider_all_requests_local = false
    config.static_cache_control = "public, max-age=30000000"
    config.log_level = :debug
  else
    config.eager_load = false
    config.cache_classes = false
    config.action_controller.perform_caching = false
    config.consider_all_requests_local = true
    config.log_level = :debug
  end


  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: "localhost:3000" }
  config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }
end