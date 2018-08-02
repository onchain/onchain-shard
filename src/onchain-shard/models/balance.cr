require "big"
require "json"

module OnChain
  module API
    
    struct Balance
    
      def initialize(
        @usd_balance : Float64,
        @balance : UInt64,
        @unconfirmed_balance : UInt64,
        @human_balance : Float64,
        @human_unconfirmed_balance : Float64)
      end
    
      JSON.mapping(
        usd_balance: Float64,
        balance: UInt64,
        unconfirmed_balance: UInt64,
        human_balance: Float64,
        human_unconfirmed_balance: Float64)
      end
    
  end
end