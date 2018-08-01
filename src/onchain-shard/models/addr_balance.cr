require "big"
require "json"

struct AddrBalance

  JSON.mapping(
    address: String,
    usd_balance: UInt64,
    balance: UInt64,
    unconfirmed_balance: UInt64,
    human_balance: Float64,
    human_unconfirmed_balance: Float64)
end

