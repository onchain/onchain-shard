require "./spec_helper"

describe OnChain::API::Multisig do

  it "should create a multi signature testnet transaction" do
  
    redeem_scripts = Array(OnChain::API::RedeemScript).new
    
    redeem_scripts << OnChain::API::RedeemScript.new([
      "02117fbaa86f7fd4369e648fa4328eefecde25b06be14abdec96e8774d5572bc9c"])

    multi_sig = OnChain::API::MultiSigPayment.new(
      1.to_u64, 
      200000.to_u64, 
      "2N42jRK9UuZ1YmjnZiMhwo6ZdyQHVTfedkB",
      0.to_u64,
      "",
      40000.to_u64,
      redeem_scripts)
      
    hashes_to_sign = OnChain::API::Multisig.create("testnet3", multi_sig)
    
    case hashes_to_sign
    when OnChain::API::HashesToSign
    
      tx = <<-END
      01000000029fa6589814ab5ade0eb7a8670db436ccc1c960779fab196e788a62d6c3591a47
      0000000025512102117fbaa86f7fd4369e648fa4328eefecde25b06be14abdec96e8774d55
      72bc9c51aeffffffffcedd564ff3eb5fee38029b6ccf5540767baca10b9506236e2e837205
      80f7b3bd0000000025512102117fbaa86f7fd4369e648fa4328eefecde25b06be14abdec96
      e8774d5572bc9c51aeffffffff02400d03000000000017a914764c8b59a3c88e8e3fdbd8a1
      b4831e2aa432d84387f259ef000000000017a9145d984dfa8e695f2ab28fd26977340b5207
      5ddf768700000000
      END
      
      hashes_to_sign.tx.should eq(tx.gsub("\n", ""))
    else
      # We shouldn't get here.
      puts hashes_to_sign.message
      true.should eq(false)
    end
  
  end
  
end