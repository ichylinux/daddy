db_config = Rails.configuration.database_configuration[Rails.env]
redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379/0'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: db_config['database'] }

  begin
    require 'sidekiq/scheduler'
  rescue LoadError
    puts 'sidekiq-scheduler is not loaded.'
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: db_config['database'] }
end
