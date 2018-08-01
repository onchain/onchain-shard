require "big"
require "json"

struct Signature

  JSON.mapping(
    hash_to_sign: String,
    signature: String,
    public_key: String,
    input_index: UInt64)
end

