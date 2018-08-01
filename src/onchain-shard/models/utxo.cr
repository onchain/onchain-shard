require "big"
require "json"

struct Utxo

  JSON.mapping(
    amount: UInt64,
    vout: UInt64,
    txid: String,
    script_pub_key: String)
end

