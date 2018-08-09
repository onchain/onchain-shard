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
  
end