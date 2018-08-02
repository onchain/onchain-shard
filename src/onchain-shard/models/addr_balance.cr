require "big"
require "json"

module OnChain
  module API
    
    struct AddrBalance
    
      def initialize(
        @address : String,
        @usd_balance : UInt64,
        @balance : UInt64,
        @unconfirmed_balance : UInt64,
        @human_balance : Float64,
        @human_unconfirmed_balance : Float64)
      end
    
      JSON.mapping(
        address: String,
        usd_balance: UInt64,
        balance: UInt64,
        unconfirmed_balance: UInt64,
        human_balance: Float64,
        human_unconfirmed_balance: Float64)
      end
    
  end
end