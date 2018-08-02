require "big"
require "json"

module OnChain
  module API
    
    struct EthereumToSign
    
      def initialize(
        @tx : String,
        @hash_to_sign : String)
      end
    
      JSON.mapping(
        tx: String,
        hash_to_sign: String)
      end
    
  end
end