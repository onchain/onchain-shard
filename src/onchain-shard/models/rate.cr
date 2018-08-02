require "big"
require "json"

module OnChain
  module API
    
    struct Rate
    
      def initialize(
        @coin : String,
        @rate : Float64)
      end
    
      JSON.mapping(
        coin: String,
        rate: Float64)
      end
    
  end
end