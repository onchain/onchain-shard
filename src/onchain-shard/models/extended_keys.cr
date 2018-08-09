require "big"
require "json"

module OnChain
  module API
    
    struct ExtendedKeys
    
      def initialize(
        @master_keys : Array(ExtendedKey))
      end
    
      JSON.mapping(
        master_keys: Array(ExtendedKey))
      end
    
  end
end