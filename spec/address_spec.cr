require "./spec_helper"

describe OnChain::API::Address do

  it "should retrieve a bitcoin balance" do
  
    resp = OnChain::API::Address.get_balance("bitcoin", 
      "1F1tAaz5x1HUXrCNLbtMDqcw6o5GNn4xqX", "", 18.to_u64)
  
    case resp
    when OnChain::API::Balance
      resp.human_balance.should be > 19.50874242
    else
      puts resp.to_s
      true.should eq(false)
    end
  end
  
  it "should convert xpubs to addresses" do
  
    xpubs = Array(OnChain::API::ExtendedKey).new 
  
    xpubs << OnChain::API::ExtendedKey.new "xpub68HJZ9inzbsZgSy8R2AwTWh7cxzvt" +
      "NKYFEXrAszoZjwMnXvrAGto3qcB9ScwZpDRQxXobNa4nb3uDqHSYnBKPoQjonLXFcjYk" +
      "ubrBeFazVb", 
      "m/0/0"
      
    keys = OnChain::API::ExtendedKeys.new 1, xpubs
  
    resp = OnChain::API::Address.to_network_addresses(keys)
  
    case resp
    when OnChain::API::NetworkAddresses
      resp.addresses.first.network_address.should eq(
        "1NJPSsYiAyikaGd97y4G5WgmWkWbVSoXwj")
    else
      puts resp.to_s
      true.should eq(false)
    end
  end
  
end