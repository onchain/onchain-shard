require "./onchain-shard/*"
require "yaml"

module Onchain::Shard
  
  yml_string = File.read("onchain.yml")
  
  yml = YAML.parse yml_string
    
  tags = Hash(String, Array(YAML::Any)).new
  tags_path = Hash(String, Array(String)).new
  
  yml["paths"].as_h.each do |key, value|
    
    case value.raw
    when Hash
      
      if value["get"]? != nil || value["post"]? != nil
      
        tag_name = value["get"]? != nil ? value["get"]["tags"].as_a.first.to_s :
          value["post"]["tags"].as_a.first.to_s
      
        if tags[tag_name]? == nil
          tags[tag_name] = Array(YAML::Any).new
        end
        tags[tag_name] << (value["get"]? != nil ? value["get"] : value["post"])
        
        if tags_path[tag_name]? == nil
          tags_path[tag_name] = Array(String).new
        end
        tags_path[tag_name] << key.to_s
      end
      
    else
      puts value.as_a.first
    end
  end
    
  tags_path.keys.each do |key|
    generate_interface(key, tags_path[key], tags[key])
  
  end
  
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
  
  def self.generate_interface(name : String, paths : Array(String), 
    params : Array(YAML::Any))
    
    change_name = name.gsub(" API", "")
  
    clazz = "require \"http/client\"\n\nclass #{change_name}\n\n"
    
    paths.each_with_index do |path, i|
      op_id = params[i]["operationId"].to_s
      clazz = clazz + "  # #{path} #{op_id}\n"
      method_name = op_id.gsub(" ", "_").downcase
      
      clazz = clazz + "  def self.#{method_name}("
      
      params[i]["parameters"].as_a.each do |param|
      
        if clazz[clazz.size - 1].to_s != "("
          clazz = clazz + ", "
        end
        
        clazz = clazz + param["name"].to_s
        if param["schema"]["type"]? != nil
          clazz = clazz + " : "
          clazz = clazz + convert_type( param["schema"]["type"].to_s)
        end
        
      end
      
      clazz = clazz + ")\n\n"
      
      
      clazz = clazz + "    response = HTTP::Client.get \"https://onchain.io/api"
      path_we_need = path
      index = path.index("{")
      if index
        path_we_need = path[0..index - 2]
      end
      clazz = clazz + path_we_need
      params[i]["parameters"].as_a.each do |param|
      
        if param["in"].to_s == "path"
        
          clazz = clazz + "/\#{" + param["name"].to_s + "}"
          
        end
        
      end
      
      clazz = clazz + "/"
      
      first = true
      params[i]["parameters"].as_a.each do |param|
      
        if param["in"].to_s == "query"
        
          if first
            clazz = clazz + "?" 
          else
            clazz = clazz + "&"
          end
          first = false
          clazz = clazz + param["name"].to_s + "=\#{" + param["name"].to_s + "}"
          
        end
        
      end
      
      clazz = clazz + "\"\n\n    raise \"Error with API\" if response.status_code != 200"
      
      array = false
      if params[i]["responses"]["default"]["content"]["application/json"]["schema"]["type"]? != nil
        array = true
        model_name = params[i]["responses"]["default"]["content"]["application/json"]["schema"]["items"]["$ref"].to_s
      else
        model_name = params[i]["responses"]["default"]["content"]["application/json"]["schema"]["$ref"].to_s
      end
      model_name = ref_to_model(model_name)
      
      clazz = clazz + "\n\n    #{model_name.downcase} = #{model_name}.from_json response.body \n"
      clazz = clazz + "\n\n    return #{model_name.downcase}\n"
      
      clazz = clazz + "  end\n\n"
    end
    
    clazz = clazz + "end"
    
    
    file_name = "src/onchain-shard/api/#{change_name.downcase}.cr"
    begin
      if File.read(file_name) != clazz
        File.open(file_name, "w") { |f| f << clazz }
      end
    rescue e
      File.open(file_name, "w") { |f| f << clazz }
    end
    
  end
  
  def self.ref_to_model(ref : String)
    ref = ref.gsub("#/components/schemas/", "")
    ref = ref.gsub("'", "")
    return ref.camelcase
  end
  
  def self.generate_model(name : String, props : Hash(YAML::Any, YAML::Any))
    
    init_def = ""
    props.each do |key, value|
      if value["type"]? != nil
        init_def = init_def +
          "    #{key.to_s}: #{convert_type(value["type"].to_s)},\n" 
      elsif value["$ref"]? != nil
        ref = ref_to_model(value["$ref"].to_s)
        init_def = init_def + "    #{key.to_s}: #{ref},\n" 
      end
    end
    init_def = init_def[0..init_def.size - 3].to_s
    
    model_class = (<<-CLASS
    require "big"
    require "json"
    
    struct #{name.camelcase}
    
      JSON.mapping(
    #{init_def})
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
      return "Float64"
    elsif type == "string"
      return "String"
    elsif type == "integer"
      return "UInt64"
    end
    
    return "String"
  end
  
end
