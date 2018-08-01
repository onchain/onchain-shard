require "big"
require "json"

struct Balance

  JSON.mapping(
    usd_balance: Float64,
    balance: UInt64,
    unconfirmed_balance: UInt64,
    human_balance: Float64,
    human_unconfirmed_balance: Float64)
end

