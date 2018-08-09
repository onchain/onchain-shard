require "http/client"

module OnChain
  module API
    class Address

      # /address/balance/{coin}/{address} Get Balance
      def self.get_balance(coin, address : String, contract_id : String, decimal_places : UInt64) : Balance | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.get "https://onchain.io/api/address/balance/#{coin}/#{address}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        balance = Balance.from_json response.body 


        return balance
      end

      # /address/balances/{coin}/{addresses} Get Balances
      def self.get_balances(coin, addresses : String, contract_id : String, decimal_places : UInt64) : Balances | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.get "https://onchain.io/api/address/balances/#{coin}/#{addresses}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        balances = Balances.from_json response.body 


        return balances
      end

      # /address/history/{coin}/{addresses} Get History
      def self.get_history(coin, addresses : String, contract_id : String, decimal_places : UInt64) : History | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.get "https://onchain.io/api/address/history/#{coin}/#{addresses}/?contract_id=#{contract_id}&decimal_places=#{decimal_places}", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        history = History.from_json response.body 


        return history
      end

      # /address/utxo/{coin}/{addresses} Get Unspent
      def self.get_unspent(coin, addresses : String) : Utxo | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.get "https://onchain.io/api/address/utxo/#{coin}/#{addresses}/", headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        utxo = Utxo.from_json response.body 


        return utxo
      end

      # /address/to_network_addresses To Network Addresses
      def self.to_network_addresses(extendedkeys : ExtendedKeys) : NetworkAddresses | ErrorMessage

        body = extendedkeys.to_json

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        response = HTTP::Client.post "https://onchain.io/api/address/to_network_addresses/", headers: headers, body: body

        return ErrorMessage.from_json response.body if response.status_code != 200

        networkaddresses = NetworkAddresses.from_json response.body 


        return networkaddresses
      end

    end
  end
end
