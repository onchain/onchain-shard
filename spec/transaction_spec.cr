require "./spec_helper"

describe Transaction do

  it "should create a testnet transaction" do
  
    pub_keys_hex = 
      "028f883177988f212f2f1b89bc0aa1fb0683899c3665b62167b0daa998018f85d7"
      
    dest_addr = "mwC6ZaXyTVnFMNYt1WRRh7sEwbDA3oHcRw"
    
    fee_addr = "n28nbaep2LLs6amVjggZhfTwUzBWsrPfmq"
      
    resp = Transaction.create(
      "testnet3",     # Coin
      dest_addr,      # To 
      pub_keys_hex,   # from 
      100000.to_u64,  # amount 
      fee_addr,       # fee_address 
      400000.to_u64,  # fee_amount
      40000.to_u64)   # miners_fee 
    
    puts resp  
  end
  
end