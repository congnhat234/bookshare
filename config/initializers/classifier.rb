require "classifier-reborn"
require "redis"

rails_root = Rails.root || File.dirname(__FILE__) + "/../.."
rails_env = Rails.env || "development"
uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")

redis_backend = ClassifierReborn::BayesRedisBackend.new(:host => uri.host, :port => uri.port, :password => uri.password, :db => 1)
CLASSIFIER_POST = ClassifierReborn::Bayes.new "Spam", "Good", backend: redis_backend
