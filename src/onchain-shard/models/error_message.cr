require "big"
require "json"

module OnChain
  module API
    
    struct ErrorMessage
    
      def initialize(
        @message : String)
      end
    
      JSON.mapping(
        message: String)
      end
    
  end
end