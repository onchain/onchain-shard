require "big"
require "json"

module OnChain
  module API
    
    struct History
    
      def initialize(
        @total_txs : UInt64,
        @txs : Array(Tx))
      end
    
      JSON.mapping(
        total_txs: UInt64,
        txs: Array(Tx))
      end
    
  end
end