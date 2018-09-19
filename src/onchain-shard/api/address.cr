require "http/client"

module OnChain
  module API
    class Address

      # /address/balance/{coin}/{address} Get Balance
      def self.get_balance(coin, address : String, contract_id : String? = nil, decimal_places : UInt64? = nil) : Balance | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        url = "https://onchain.io/api/address/balance/#{coin}/#{address}/"

        params = HTTP::Params.parse("")
        params.add("contract_id", "#{contract_id}") if contract_id
        params.add("decimal_places", "#{decimal_places}") if decimal_places


        if params.size > 0
          url += "?" + params.to_s
        end

        response = HTTP::Client.get url, headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        balance = Balance.from_json response.body 


        return balance
      end

      # /address/balances/{coin}/{addresses} Get Balances
      def self.get_balances(coin, addresses : String, contract_id : String? = nil, decimal_places : UInt64? = nil) : Balances | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        url = "https://onchain.io/api/address/balances/#{coin}/#{addresses}/"

        params = HTTP::Params.parse("")
        params.add("contract_id", "#{contract_id}") if contract_id
        params.add("decimal_places", "#{decimal_places}") if decimal_places


        if params.size > 0
          url += "?" + params.to_s
        end

        response = HTTP::Client.get url, headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        balances = Balances.from_json response.body 


        return balances
      end

      # /address/history/{coin}/{addresses} Get History
      def self.get_history(coin, addresses : String, contract_id : String? = nil, decimal_places : UInt64? = nil) : History | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        url = "https://onchain.io/api/address/history/#{coin}/#{addresses}/"

        params = HTTP::Params.parse("")
        params.add("contract_id", "#{contract_id}") if contract_id
        params.add("decimal_places", "#{decimal_places}") if decimal_places


        if params.size > 0
          url += "?" + params.to_s
        end

        response = HTTP::Client.get url, headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        history = History.from_json response.body 


        return history
      end

      # /address/utxos/{coin}/{addresses} Get Unspent
      def self.get_unspent(coin, addresses : String) : Utxos | ErrorMessage

        headers = HTTP::Headers.new
        if ENV["ONCHAIN_API_KEY"]? != nil
          headers.add("X-API-KEY", ENV["ONCHAIN_API_KEY"])
        end

        url = "https://onchain.io/api/address/utxos/#{coin}/#{addresses}/"

        params = HTTP::Params.parse("")


        if params.size > 0
          url += "?" + params.to_s
        end

        response = HTTP::Client.get url, headers: headers

        return ErrorMessage.from_json response.body if response.status_code != 200

        utxos = Utxos.from_json response.body 


        return utxos
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
