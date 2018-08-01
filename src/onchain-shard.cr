require "./onchain-shard/*"
require "yaml"

module Onchain::Shard
  
  yml_string = File.read("onchain.yml")
  
  yml = YAML.parse yml_string
  
  yml["components"]["schemas"].as_h.each do |key, value|
    
    case value.raw
    when Hash
      type, obj = value.as_h.first
      
      if obj == "object"
        generate_model(key.to_s, value.as_h["properties"].as_h)
      end
    else
      puts value.as_a.first
    end
  end
  
  def self.generate_model(name : String, props : Hash(YAML::Any, YAML::Any))
  
    property_def = ""
    props.each do |key, value|
      if value["type"]? != nil
        property_def = property_def +
          "  property #{key.to_s} : #{convert_type(value["type"].to_s)}\n" 
      end
    end
    
    model_class = (<<-CLASS
    struct #{name.camelcase}
    
    #{property_def}
    end
    CLASS
    )
    
    file_name = "src/onchain-shard/models/#{name}.cr"
    if File.read(file_name) != model_class
      File.open(file_name, "w") { |f| f << model_class }
    end
  end
  
  def self.convert_type(type : String) : String
    if type == "number"
      return "Float"
    elsif type == "string"
      return "String"
    elsif type == "integer"
      return "BigInt"
    end
    
    return "Undefined"
  end
  
end
