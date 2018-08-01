require "./spec_helper"

describe Address do

  it "should retrieve a bitcoin balance" do
  
    resp = Address.get_balance("bitcoin", 
      "1F1tAaz5x1HUXrCNLbtMDqcw6o5GNn4xqX", "", 18.to_u64)
  
    resp.human_balance.should eq(19.50874242)
  end
  
end