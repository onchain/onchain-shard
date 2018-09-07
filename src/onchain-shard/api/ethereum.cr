require "http/client"

module OnChain
  module API
    class Ethereum

      # /ethereum/create/ Create
      def self.create(to : String, from : String, amount : UInt64, gas_price : UInt64? = nil, gas_limit : UInt64? = nil) : EthereumToSign | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.post "https://onchain.io/api/ethereum/create//?to=#{to}&from=#{from}&amount=#{amount}&gas_price=#{gas_price}&gas_limit=#{gas_limit}", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        ethereumtosign = EthereumToSign.from_json response.body 


        return ethereumtosign
      end

      # /ethereum/sign_and_send/ Sign and send
      def self.sign_and_send(to : String, from : String, amount : UInt64, r : String, s : String, v : String, gas_price : UInt64? = nil, gas_limit : UInt64? = nil) : SendStatus | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.post "https://onchain.io/api/ethereum/sign_and_send//?to=#{to}&from=#{from}&amount=#{amount}&r=#{r}&s=#{s}&v=#{v}&gas_price=#{gas_price}&gas_limit=#{gas_limit}", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

    end
  end
end
