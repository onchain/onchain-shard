require "big"
require "json"

module OnChain
  module API
    
    struct Signatures
    
      def initialize(
        @tx : String,
        @signatures : Array(Signature))
      end
    
      JSON.mapping(
        tx: String,
        signatures: Array(Signature))
      end
    
  end
end