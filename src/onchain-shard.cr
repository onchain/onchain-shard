require "./onchain-shard/*"
require "./onchain-shard/codegen/*"
require "yaml"

module Onchain::Shard
  
  yml_string = File.read("onchain.yml")
  
  yml = YAML.parse yml_string
    
  ModelGenerator.generate_models(yml)
  
  APIGenerator.generate_api(yml)
  
end
