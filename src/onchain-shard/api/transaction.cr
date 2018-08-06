require "http/client"

module OnChain
  module API
    class Transaction

      # /transaction/create/{coin} Create
      def self.create(coin, to : String, from : String, amount : UInt64, fee_address : String, fee_amount : UInt64, miners_fee : UInt64) : HashesToSign | ErrorMessage

        response = HTTP::Client.post "https://onchain.io/api/transaction/create/#{coin}/?to=#{to}&from=#{from}&amount=#{amount}&fee_address=#{fee_address}&fee_amount=#{fee_amount}&miners_fee=#{miners_fee}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        hashestosign = HashesToSign.from_json response.body 


        return hashestosign
      end

      # /transaction/sign_and_send/{coin} Sign and send
      def self.sign_and_send(coin, signatures : Signatures) : SendStatus | ErrorMessage

        body = signatures.to_json

        response = HTTP::Client.post "https://onchain.io/api/transaction/sign_and_send/#{coin}/", body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

      # /transaction/send_raw/{coin} Send Raw
      def self.send_raw(coin, rawtx : String) : SendStatus | ErrorMessage

        response = HTTP::Client.post "https://onchain.io/api/transaction/send_raw/#{coin}/?rawtx=#{rawtx}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

    end
  end
end
