require "big"
require "json"

module OnChain
  module API
    
    struct NetworkAddress
    
      def initialize(
        @network_address : String,
        @coin : String)
      end
    
      JSON.mapping(
        network_address: String,
        coin: String)
      end
    
  end
end