require "big"
require "json"

module OnChain
  module API
    
    struct NetworkAddresses
    
      def initialize(
        @addresses : Array(NetworkAddress))
      end
    
      JSON.mapping(
        addresses: Array(NetworkAddress))
      end
    
  end
end