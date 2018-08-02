require "big"
require "json"

module OnChain
  module API
    
    struct Signatures
    
      def initialize(
        @tx : String,
        @signatures : Signature)
      end
    
      JSON.mapping(
        tx: String,
        signatures: Signature)
      end
    
  end
end