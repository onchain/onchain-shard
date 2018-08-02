require "big"
require "json"

module OnChain
  module API
    
    struct Rates
    
      def initialize(
        @rates : Rate)
      end
    
      JSON.mapping(
        rates: Rate)
      end
    
  end
end