require "big"
require "json"

struct EthereumToSign

  JSON.mapping(
    tx: String,
    hash_to_sign: String)
end

