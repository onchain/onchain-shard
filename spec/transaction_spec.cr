require "./spec_helper"

describe OnChain::API::Transaction do

  it "should create a testnet transaction" do
  
    pub_keys_hex = 
      "028f883177988f212f2f1b89bc0aa1fb0683899c3665b62167b0daa998018f85d7"
      
    dest_addr = "mwC6ZaXyTVnFMNYt1WRRh7sEwbDA3oHcRw"
    
    fee_addr = "n28nbaep2LLs6amVjggZhfTwUzBWsrPfmq"
      
    hashes_to_sign = OnChain::API::Transaction.create(
      "testnet3",     # Coin
      dest_addr,      # To 
      pub_keys_hex,   # from 
      100000.to_u64,  # amount 
      fee_addr,       # fee_address 
      400000.to_u64,  # fee_amount
      40000.to_u64)   # miners_fee 
      
    case hashes_to_sign
    when OnChain::API::HashesToSign
    
      hashes_to_sign.tx.size.should be > 10
      
      hashes_to_sign.hashes.size.should eq 1 
      
      sigs = Array(OnChain::API::Signature).new
      
      sigs << OnChain::API::Signature.new(hashes_to_sign.hashes[0].hash_to_sign, 
        "3045022100f7c70d5678fb2322f6bce3c5d0ee2bd7a07435e22b4402aea75dc1e8f2" +
        "d31f63022020562012d200e650c9df4d56060708c38c72ba6874f5fc3f9f88b19f6b" +
        "434a70",
        hashes_to_sign.hashes[0].public_key,
        hashes_to_sign.hashes[0].input_index)
      
      signatures = OnChain::API::Signatures.new(hashes_to_sign.tx, sigs)
      
      result = OnChain::API::Transaction.sign_and_send("testnet3", signatures)
    else
      # We shouldn't get here.
      true.should eq(false)
    end
  end
  
end