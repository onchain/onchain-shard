require "big"
require "json"

module OnChain
  module API
    
    struct HashesToSign
    
      def initialize(
        @tx : String,
        @total_input_value : UInt64,
        @hashes : Array(HashToSign))
      end
    
      JSON.mapping(
        tx: String,
        total_input_value: UInt64,
        hashes: Array(HashToSign))
      end
    
  end
end