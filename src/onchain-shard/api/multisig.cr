require "http/client"

module OnChain
  module API
    class Multisig

      # /multi_sig/create/{coin} Create
      def self.create(coin, multisigpayment : MultiSigPayment) : HashesToSign | ErrorMessage

        body = multisigpayment.to_json

        response = HTTP::Client.post "https://onchain.io/api/multi_sig/create/#{coin}/", body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        hashestosign = HashesToSign.from_json response.body 


        return hashestosign
      end

      # /multi_sig/sign_and_send/{coin} Sign and send
      def self.sign_and_send(coin, signatures : Signatures) : SendStatus | ErrorMessage

        body = signatures.to_json

        response = HTTP::Client.post "https://onchain.io/api/multi_sig/sign_and_send/#{coin}/", body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

    end
  end
end
