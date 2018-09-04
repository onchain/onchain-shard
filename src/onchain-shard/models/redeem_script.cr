require "big"
require "json"

module OnChain
  module API
    
    struct RedeemScript
    
      def initialize(
        @public_keys : Array(String))
      end
    
      JSON.mapping(
        public_keys: Array(String))
      end
    
  end
end