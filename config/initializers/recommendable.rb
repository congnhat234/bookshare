require 'redis'

rails_root = Rails.root || File.dirname(__FILE__) + "/../.."
rails_env = Rails.env || "development"
redis_config = YAML.load_file(rails_root.to_s + "/config/redis.yml")
redis_config.merge! redis_config.fetch(Rails.env, {})
redis_config.symbolize_keys!

Recommendable.configure do |config|
  # Recommendable's connection to Redis.
  #
  # Default: localhost:6379/0
  config.redis = Redis.new(:host => redis_config[:host], :port => redis_config[:port], :db => 0)

  # A prefix for all keys Recommendable uses.
  #
  # Default: recommendable
  config.redis_namespace = :recommendable

  # Whether or not to automatically enqueue users to have their recommendations
  # refreshed after they like/dislike an item.
  #
  # Default: true
  config.auto_enqueue = true

  # The number of nearest neighbors (k-NN) to check when updating
  # recommendations for a user. Set to `nil` if you want to check all
  # neighbors as opposed to a subset of the nearest ones. Set this to a lower
  # number to improve Redis memory usage.
  #
  # Default: nil
  config.nearest_neighbors = nil

  # Like kNN, but also uses some number of most dissimilar users when
  # updating recommendations for a user. Because, hey, disagreements are
  # just as important as agreements, right? If `nearest_neighbors` is set to
  # `nil`, this configuration is ignored. Set this to a lower number
  # to improve Redis memory usage.
  #
  # Default: nil
  config.furthest_neighbors = nil

  # The number of recommendations to store per user. Set this to a lower
  # number to improve Redis memory usage.
  #
  # Default: 100
  config.recommendations_to_store = 100

  config.orm = :active_record
end
