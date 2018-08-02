require "big"
require "json"

module OnChain
  module API
    
    struct HashToSign
    
      def initialize(
        @input_index : UInt64,
        @public_key : String,
        @hash_to_sign : String)
      end
    
      JSON.mapping(
        input_index: UInt64,
        public_key: String,
        hash_to_sign: String)
      end
    
  end
end