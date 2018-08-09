require "big"
require "json"

module OnChain
  module API
    
    struct ExtendedKeys
    
      def initialize(
        @number_of_required_signatures : UInt64,
        @master_keys : Array(ExtendedKey))
      end
    
      JSON.mapping(
        number_of_required_signatures: UInt64,
        master_keys: Array(ExtendedKey))
      end
    
  end
end