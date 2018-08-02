require "big"
require "json"

module OnChain
  module API
    
    struct MultiSigPayment
    
      def initialize(
        @number_of_required_signatures : UInt64,
        @amount : UInt64,
        @to : String,
        @fee_amount : UInt64,
        @fee_address : String,
        @miners_fee : UInt64,
        @redeem_scripts : RedeemScript)
      end
    
      JSON.mapping(
        number_of_required_signatures: UInt64,
        amount: UInt64,
        to: String,
        fee_amount: UInt64,
        fee_address: String,
        miners_fee: UInt64,
        redeem_scripts: RedeemScript)
      end
    
  end
end