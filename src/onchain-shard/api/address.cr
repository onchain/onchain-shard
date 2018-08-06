require "http/client"

module OnChain
  module API
    class Address

      # /address/balance/{coin}/{address} Get Balance
      def self.get_balance(coin, address : String, contract_id : String, decimal_places : UInt64) : Balance | ErrorMessage

        response = HTTP::Client.get "https://onchain.io/api/address/balance/#{coin}/#{address}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        balance = Balance.from_json response.body 


        return balance
      end

      # /address/balances/{coin}/{addresses} Get Balances
      def self.get_balances(coin, addresses : String, contract_id : String, decimal_places : UInt64) : Balances | ErrorMessage

        response = HTTP::Client.get "https://onchain.io/api/address/balances/#{coin}/#{addresses}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        balances = Balances.from_json response.body 


        return balances
      end

      # /address/history/{coin}/{addresses} Get History
      def self.get_history(coin, addresses : String, contract_id : String, decimal_places : UInt64) : History | ErrorMessage

        response = HTTP::Client.get "https://onchain.io/api/address/history/#{coin}/#{addresses}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}"

        return ErrorMessage.from_json response.body if response.status_code != 200

        history = History.from_json response.body 


        return history
      end

      # /address/utxo/{coin}/{addresses} Get Unspent
      def self.get_unspent(coin, addresses : String) : Utxo | ErrorMessage

        response = HTTP::Client.get "https://onchain.io/api/address/utxo/#{coin}/#{addresses}/"

        return ErrorMessage.from_json response.body if response.status_code != 200

        utxo = Utxo.from_json response.body 


        return utxo
      end

    end
  end
end
