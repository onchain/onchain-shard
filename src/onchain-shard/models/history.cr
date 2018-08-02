require "big"
require "json"

struct History

  JSON.mapping(
    total_txs: UInt64,
    txs: Array(Tx))
end

