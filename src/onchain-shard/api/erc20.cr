require "http/client"

module OnChain
  module API
    class ERC20

      # /erc20/create/ Create
      def self.create(to : String, from : String, amount : UInt64, contract_id : String, decimal_places : UInt64, gas_price : UInt64, gas_limit : UInt64) : EthereumToSign | ErrorMessage

        response = HTTP::Client.post "https://onchain.io/api/erc20/create//?to=#{to}&from=#{from}&amount=#{amount}&contract_id=#{contract_id}&decimal_places=#{decimal_places}&gas_price=#{gas_price}&gas_limit=#{gas_limit}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        ethereumtosign = EthereumToSign.from_json response.body 


        return ethereumtosign
      end

      # /erc20/sign_and_send/ Sign and send
      def self.sign_and_send(to : String, from : String, amount : UInt64, contract_id : String, decimal_places : UInt64, r : String, s : String, v : String, gas_price : UInt64, gas_limit : UInt64) : SendStatus | ErrorMessage

        response = HTTP::Client.post "https://onchain.io/api/erc20/sign_and_send//?to=#{to}&from=#{from}&amount=#{amount}&contract_id=#{contract_id}&decimal_places=#{decimal_places}&r=#{r}&s=#{s}&v=#{v}&gas_price=#{gas_price}&gas_limit=#{gas_limit}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

    end
  end
end
