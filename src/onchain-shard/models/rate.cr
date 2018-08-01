require "big"
require "json"

struct Rate

  JSON.mapping(
    coin: String,
    rate: Float64)
end

