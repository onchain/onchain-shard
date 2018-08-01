require "big"
require "json"

struct HashToSign

  JSON.mapping(
    input_index: UInt64,
    public_key: String,
    hash_to_sign: String)
end

