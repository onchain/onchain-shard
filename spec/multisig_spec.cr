require "./spec_helper"

describe OnChain::API::Multisig do

  it "should create a multi signature testnet transaction" do
  
    redeem_scripts = Array(OnChain::API::RedeemScript).new
    
    redeem_scripts << OnChain::API::RedeemScript.new([
      "02fd89e243d38f4e24237eaac4cd3a6873ce45aa4036ec0c7b79a4d4ac0fefebc4", 
      "0396e42d3c584da0300ee44dcbaee0eccaa0e6ae2264fdd2554af6d2953f95bf99"])
      
    multi_sig = OnChain::API::MultiSigPayment.new(
      2.to_u64, 
      11366.to_u64, 
      "mwC6ZaXyTVnFMNYt1WRRh7sEwbDA3oHcRw",
      0.to_u64,
      "",
      0.to_u64,
      redeem_scripts)
      
    hashes_to_sign = OnChain::API::Multisig.create("testnet3", multi_sig)
    
    case hashes_to_sign
    when OnChain::API::HashesToSign
      puts hashes_to_sign
    else
      # We shouldn't get here.
      puts hashes_to_sign.message
      true.should eq(false)
    end
  
  end
  
end