require "big"
require "json"

module OnChain
  module API
    
    struct Balances
    
      def initialize(
        @totals : Balance,
        @addresses : Array(AddrBalance))
      end
    
      JSON.mapping(
        totals: Balance,
        addresses: Array(AddrBalance))
      end
    
  end
end