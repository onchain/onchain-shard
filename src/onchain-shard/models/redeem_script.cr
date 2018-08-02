require "big"
require "json"

module OnChain
  module API
    
    struct RedeemScript
    
      def initialize(
        @public_key : String)
      end
    
      JSON.mapping(
        public_key: String)
      end
    
  end
end