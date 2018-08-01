require "big"
require "json"

struct Tx

  JSON.mapping(
    confirmations: UInt64,
    time: UInt64,
    is_deposit: String,
    address: String,
    amount: UInt64,
    human_amount: Float64)
end

