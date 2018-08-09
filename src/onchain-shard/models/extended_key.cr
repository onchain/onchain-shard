require "big"
require "json"

module OnChain
  module API
    
    struct ExtendedKey
    
      def initialize(
        @xpub : String,
        @path : String)
      end
    
      JSON.mapping(
        xpub: String,
        path: String)
      end
    
  end
end