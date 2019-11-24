rails_root = Rails.root || File.dirname(__FILE__) + "/../.."
rails_env = Rails.env || "development"
redis_config = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"

Sidekiq.configure_server do |config|
  config.redis = { url: "#{redis_config}/12", :size => 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{redis_config}/12", :size => 1 }
end
