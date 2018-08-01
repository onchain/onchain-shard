require "http/client"

class Transaction

  # /transaction/create/{coin} Create
  def self.create(coin, to : String, from : String, amount : UInt64, fee_address : String, fee_amount : String, miners_fee : UInt64)

    response = HTTP::Client.get "https://onchain.io/api/transaction/create/#{coin}/?to=#{to}&from=#{from}&amount=#{amount}&fee_address=#{fee_address}&fee_amount=#{fee_amount}&miners_fee=#{miners_fee}"

    raise "Error with API" if response.status_code != 200

    hashestosign = HashesToSign.from_json response.body 


    return hashestosign
  end

  # /transaction/sign_and_send/{coin} Sign and send
  def self.sign_and_send(coin)

    response = HTTP::Client.get "https://onchain.io/api/transaction/sign_and_send/#{coin}/"

    raise "Error with API" if response.status_code != 200

    sendstatus = SendStatus.from_json response.body 


    return sendstatus
  end

  # /transaction/send_raw/{coin} Send Raw
  def self.send_raw(coin, rawtx : String)

    response = HTTP::Client.get "https://onchain.io/api/transaction/send_raw/#{coin}/?rawtx=#{rawtx}"

    raise "Error with API" if response.status_code != 200

    sendstatus = SendStatus.from_json response.body 


    return sendstatus
  end

end