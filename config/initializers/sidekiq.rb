cfg = { url: ENV.fetch('SIDEKIQ_REDIS_URL', 'redis://redis:6379/1'), timeout: 10 }

Sidekiq.configure_client do |config|
  config.redis = cfg
end

Sidekiq.configure_server do |config|
  config.redis = cfg
end
