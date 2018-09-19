require "big"
require "json"

module OnChain
  module API
    
    struct Utxos
    
      def initialize(
        @utxos : Array(Utxo))
      end
    
      JSON.mapping(
        utxos: Array(Utxo))
      end
    
  end
end