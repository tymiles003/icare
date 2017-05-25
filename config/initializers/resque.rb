# frozen_string_literal: true

if defined?(Resque) && defined?(Redis)
  Resque.redis = Redis.new(url: APP_CONFIG.redis.url)
end

# Web interface
if defined?(Resque::Server)
  Resque::Server.use(Rack::Auth::Basic) do |user_name, password|
    # rubocop:disable Style/YodaCondition
    [APP_CONFIG.resque.user_name, APP_CONFIG.resque.password] == [user_name, password]
    # rubocop:enable Style/YodaCondition
  end
end
