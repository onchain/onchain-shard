require "big"
require "json"

struct Balances

  JSON.mapping(
    totals: Balance,
    addresses: Array(AddrBalance))
end

