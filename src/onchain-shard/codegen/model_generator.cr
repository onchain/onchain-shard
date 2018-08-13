class ModelGenerator

  def self.generate_models(yml : YAML::Any)
  
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
    
  end
  
  def self.generate_model(name : String, props : Hash(YAML::Any, YAML::Any))
    
    init_def = ""
    props.each do |key, value|
      if value["type"]? != nil
      
        the_type =value["type"].to_s
        # Is it an array
        if value["items"]? != nil
        
          the_items = value["items"]["$ref"]? != nil ? 
            value["items"]["$ref"].to_s : value["items"]["type"].to_s
          init_def = init_def +
            "        @#{key.to_s} : #{convert_type(the_type, the_items)},\n" 
        else
          init_def = init_def +
            "        @#{key.to_s} : #{convert_type(the_type)},\n" 
        end
          
      elsif value["$ref"]? != nil
        ref = APIGenerator.ref_to_model(value["$ref"].to_s)
        init_def = init_def + "        @#{key.to_s} : #{ref},\n" 
      end
    end
    init_def = init_def[0..init_def.size - 3].to_s
    
    model_class = (<<-CLASS
    require "big"
    require "json"
    
    module OnChain
      module API
        
        struct #{name.camelcase}
        
          def initialize(
    #{init_def})
          end
        
          JSON.mapping(
    #{init_def.gsub("@", "").gsub(" :", ":")})
          end
        
      end
    end
    CLASS
    )
    
    file_name = "src/onchain-shard/models/#{name}.cr"
    if File.read(file_name) != model_class
      File.open(file_name, "w") { |f| f << model_class }
    end
  end
  
  def self.convert_type(type : String, items : String = "") : String
    if type == "number"
      return "Float64"
    elsif type == "string"
      return "String"
    elsif type == "integer"
      return "UInt64"
    elsif type == "array"
      return "Array(" + APIGenerator.ref_to_model(items) + ")"
    end
    
    return "String"
  end
  
end