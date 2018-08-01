require "big"
require "json"

struct Signatures

  JSON.mapping(
    tx: String,
    signatures: Signature)
end

