require "big"
require "json"

module OnChain
  module API
    
    struct Tx
    
      def initialize(
        @confirmations : UInt64,
        @time : UInt64,
        @is_deposit : String,
        @address : String,
        @amount : UInt64,
        @human_amount : Float64)
      end
    
      JSON.mapping(
        confirmations: UInt64,
        time: UInt64,
        is_deposit: String,
        address: String,
        amount: UInt64,
        human_amount: Float64)
      end
    
  end
end