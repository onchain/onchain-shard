require "big"
require "json"

module OnChain
  module API
    
    struct Signature
    
      def initialize(
        @hash_to_sign : String,
        @signature : String,
        @public_key : String,
        @input_index : UInt64)
      end
    
      JSON.mapping(
        hash_to_sign: String,
        signature: String,
        public_key: String,
        input_index: UInt64)
      end
    
  end
end