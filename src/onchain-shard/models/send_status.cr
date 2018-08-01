require "big"
require "json"

struct SendStatus

  JSON.mapping(
    status_code: UInt64,
    message: String)
end

