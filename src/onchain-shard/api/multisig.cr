require "http/client"

class Multisig

  # /multi_sig/create/{coin} Create
  def self.create(coin) : HashesToSign

    response = HTTP::Client.post "https://onchain.io/api/multi_sig/create/#{coin}/"

    raise "Error with API" if response.status_code != 200

    hashestosign = HashesToSign.from_json response.body 


    return hashestosign
  end

  # /multi_sig/sign_and_send/{coin} Sign and send
  def self.sign_and_send(coin) : SendStatus

    response = HTTP::Client.post "https://onchain.io/api/multi_sig/sign_and_send/#{coin}/"

    raise "Error with API" if response.status_code != 200

    sendstatus = SendStatus.from_json response.body 


    return sendstatus
  end

end