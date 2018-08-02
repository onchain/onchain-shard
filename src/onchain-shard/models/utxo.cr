require "big"
require "json"

module OnChain
  module API
    
    struct Utxo
    
      def initialize(
        @amount : UInt64,
        @vout : UInt64,
        @txid : String,
        @script_pub_key : String)
      end
    
      JSON.mapping(
        amount: UInt64,
        vout: UInt64,
        txid: String,
        script_pub_key: String)
      end
    
  end
end