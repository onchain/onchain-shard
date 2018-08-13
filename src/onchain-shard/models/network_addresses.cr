require "big"
require "json"

module OnChain
  module API
    
    struct NetworkAddresses
    
      def initialize(
        @addresses : Array(NetworkAddress),
        @public_keys : Array(String))
      end
    
      JSON.mapping(
        addresses: Array(NetworkAddress),
        public_keys: Array(String))
      end
    
  end
end