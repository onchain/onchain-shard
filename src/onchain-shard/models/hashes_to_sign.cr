require "big"
require "json"

struct HashesToSign

  JSON.mapping(
    tx: String,
    total_input_value: UInt64,
    hashes: String)
end

