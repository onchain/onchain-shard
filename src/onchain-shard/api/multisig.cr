require "http/client"

module OnChain
  module API
    class Multisig

      # /multi_sig/create/{coin} Create
      def self.create(coin, multisigpayment : MultiSigPayment) : HashesToSign | ErrorMessage

        body = multisigpayment.to_json

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.post "https://onchain.io/api/multi_sig/create/#{coin}/", headers: headers, body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        hashestosign = HashesToSign.from_json response.body 


        return hashestosign
      end

      # /multi_sig/sign_and_send/{coin} Sign and send
      def self.sign_and_send(coin, signatures : Signatures) : SendStatus | ErrorMessage

        body = signatures.to_json

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.post "https://onchain.io/api/multi_sig/sign_and_send/#{coin}/", headers: headers, body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        sendstatus = SendStatus.from_json response.body 


        return sendstatus
      end

    end
  end
end
