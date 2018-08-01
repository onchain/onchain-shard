require "big"
require "json"

struct MultiSigPayment

  JSON.mapping(
    number_of_required_signatures: UInt64,
    amount: UInt64,
    to: String,
    fee_amount: UInt64,
    fee_address: String,
    miners_fee: UInt64,
    redeem_scripts: RedeemScript)
end

