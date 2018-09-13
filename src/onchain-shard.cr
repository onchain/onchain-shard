require "./onchain-shard/**"
require "yaml"
require "option_parser"

module Onchain::Shard
  
  if ARGV.size > 0 && ARGV[0] == "-g"
    yml_string = File.read("onchain.yml")
    
    yml = YAML.parse yml_string
      
    ModelGenerator.generate_models(yml)
    
    APIGenerator.generate_api(yml)
  else
    puts "Call with an argument to get code to generate. -- -g" 
  end
  
end
