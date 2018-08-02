require "big"
require "json"

module OnChain
  module API
    
    struct SendStatus
    
      def initialize(
        @status_code : UInt64,
        @message : String)
      end
    
      JSON.mapping(
        status_code: UInt64,
        message: String)
      end
    
  end
end