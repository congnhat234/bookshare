uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6739")
$redis = Redis::Namespace.new("bookshare", redis: Redis.new(:url => uri))
